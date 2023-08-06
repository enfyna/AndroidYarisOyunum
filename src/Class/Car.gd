class_name Car
extends VehicleBody3D

signal gear_changed
signal wheel_changed
signal started_lap
signal penalty_received

@export var HP : float = 100.0
@export var BRAKE_FORCE : float = 50.0

@export var MAX_STEER_SPEED : float = 30.0

@export var GEAR_RATIO : Array[float] = [-1.0, 0.0, 2.69, 2.01, 1.59, 1.32, 1.13, 1.0]
@export var GEAR_SHIFT_TIME : float = 1.0
@export var FINAL_DRIVE_RATIO : float = 3.38

@export var MAX_ENGINE_RPM : float = 8000.0

@export var POWER_CURVE : Curve = null

@export var BRAKE_LIGHT : Node
@export var REVERSE_LIGHT : Node

enum STATE{
	THROTTLE,
	BRAKE,
	CLUTCH,
	STEER,
	GEAR,
	ENGINE_RPM,
	SPEED_MPS,
	WHEEL_TYPE,
	WHEEL_LIFE,
	ABS,
	OIL,
	ENGINE,
	SPEED_UNIT,
	LAP_TIME,
	CURRENT_LAP,
}

var states : Array[float] = [
	0.0,
	0.0,
	1.0,
	0.0,
	2,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0,
	0,
	0,
]

var left_gear_shift_time : float = 0.0
enum gear_state {
	REVERSE,
	NEUTRAL,
	FORWARD,
}

var last_position : Vector3 = position
var wheel_circumference : float
enum WHEEL_COMPOUNDS {
	ECONOMY,
	COMFORT,
	HARD,
	MEDIUM,
	SOFT,
	SUPER_SOFT,
}

var race_man : Node
var id : int # Car id given by race manager
var is_bot : bool = false

var lap_started : bool = false
var best_lap : float = -1
var last_laps : Array[float] = []

func _ready():
	for node in get_children():
		if node is VehicleWheel3D:
			wheel_circumference = 2.0 * PI * node.wheel_radius
			break
	started_lap.connect(new_lap_started)
	pass

func new_lap_started():
	states[STATE.CURRENT_LAP] += 1

	if states[STATE.CURRENT_LAP] == 1:
		lap_started = true
		states[STATE.LAP_TIME] = 0
		return

	var current_lap : float = states[STATE.LAP_TIME]
	
	if best_lap == -1:
		best_lap = current_lap
	elif best_lap > current_lap:
		best_lap = current_lap

	last_laps.append(current_lap)

	states[STATE.LAP_TIME] = 0
	pass

# calculate the RPM of our engine based on the current velocity of our car
func calculate_rpm() -> float:
	if states[STATE.GEAR] == gear_state.NEUTRAL:
		return lerp(states[STATE.ENGINE_RPM], 1000.0+states[STATE.THROTTLE]*(MAX_ENGINE_RPM-1000), 0.01)

	# var wheel_rotation_speed : float = 60.0 * states[STATE.SPEED_MPS] / wheel_circumference
	# var drive_shaft_rotation_speed : float = wheel_rotation_speed * FINAL_DRIVE_RATIO

	var drive_shaft_rotation_speed : float = FINAL_DRIVE_RATIO * 60.0 * states[STATE.SPEED_MPS] / wheel_circumference

	# return lerp(states[STATE.ENGINE_RPM],(min(MAX_ENGINE_RPM,max(1000.0, drive_shaft_rotation_speed * GEAR_RATIO[states[STATE.GEAR]]))),0.01)
	return min(MAX_ENGINE_RPM,max(1000.0, drive_shaft_rotation_speed * GEAR_RATIO[states[STATE.GEAR]]))

var GEAR_TWEEN : Tween
const CLUTCH_THRESHOLD : float = 0.1
func change_gear(new_gear: int) -> void:
	if 	new_gear < 0 or\
		new_gear >= GEAR_RATIO.size() or\
		new_gear == states[STATE.GEAR]:
		return
	var lambda : Callable = func(val : float):
		if val < CLUTCH_THRESHOLD:
			states[STATE.GEAR] = new_gear
			if new_gear == Car.gear_state.REVERSE:
				REVERSE_LIGHT.show()
			else:
				REVERSE_LIGHT.hide()
			emit_signal("gear_changed")
		states[STATE.CLUTCH] = abs(val)
		pass
	if GEAR_TWEEN:
		GEAR_TWEEN.kill()
	GEAR_TWEEN = create_tween()
	GEAR_TWEEN.tween_method(lambda, states[STATE.CLUTCH], -1.0, GEAR_SHIFT_TIME)
	pass

func _process(delta : float) -> void:
	if lap_started:
		states[STATE.LAP_TIME] += delta

func _physics_process(delta : float) -> void:
	states[STATE.SPEED_MPS] = (position - last_position).length() / delta

	states[STATE.ENGINE_RPM] = calculate_rpm()
	var rpm_factor : float = clamp(states[STATE.ENGINE_RPM] / MAX_ENGINE_RPM, 0.0, 1.0)
	var power_factor : float = POWER_CURVE.sample_baked(rpm_factor)

	engine_force = states[STATE.CLUTCH] * states[STATE.THROTTLE] * power_factor * GEAR_RATIO[int(states[STATE.GEAR])] * FINAL_DRIVE_RATIO * HP

	brake = states[STATE.BRAKE] * BRAKE_FORCE
	BRAKE_LIGHT.visible = true if states[STATE.BRAKE] > 0.0 else false
	# var max_steer_speed : float = MAX_STEER_SPEED * 1000.0 / 3600.0
	# var steer_speed_factor : float = clamp(states[STATE.SPEED_MPS] / max_steer_speed, 0.0, 1.0)
	# if (abs(states[STATE.STEER]) < 0.05):
	# 	states[STATE.STEER] = 0.0
	# elif steer_curve:
	# 	if states[STATE.STEER] < 0.0:
	# 		states[STATE.STEER] = -steer_curve.interpolate_baked(-states[STATE.STEER])
	# 	else:
	# 		states[STATE.STEER] = steer_curve.interpolate_baked(states[STATE.STEER])

	# steer_angle = states[STATE.STEER] * lerp(max_steer_angle_rad, speed_steer_angle_rad, steer_speed_factor)
	steering = -states[STATE.STEER]

	# remember where we are
	last_position = position
