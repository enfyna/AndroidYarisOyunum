class_name Car
extends VehicleBody3D

signal gear_changed
signal wheel_changed
signal completed_lap

@export var HP : float = 100.0
@export var BRAKE_FORCE : float = 50.0

@export var MAX_STEER_SPEED : float = 30.0

@export var GEAR_RATIO : Array[float] = [-1.0, 0.0, 2.69, 2.01, 1.59, 1.32, 1.13, 1.0]
@export var GEAR_SHIFT_TIME : float = 1.0
@export var FINAL_DRIVE_RATIO : float = 3.38

@export var MAX_ENGINE_RPM : float = 8000.0

@export var POWER_CURVE : Curve = null

@export var RIGHT_REAR_WHEEL_RADIUS : float = 0.283

@export var CONTROLLER : Node = null
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
}
var states : Array[float] = [
	1.0,
	0.0,
	1.0,
	0.0,
	5,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
	0.0,
]

var left_gear_shift_time : float = 0.0
enum gear_state {
	REVERSE,
	NEUTRAL,
	FORWARD,
}

var last_position : Vector3 = position

func _ready():
	pass

func get_speed_kph() -> float:
	return states[STATE.SPEED_MPS] * 3.6

# calculate the RPM of our engine based on the current velocity of our car
func calculate_rpm() -> float:
	# if we are in neutral, no rpm
	if states[STATE.GEAR] == gear_state.NEUTRAL or states[STATE.GEAR] > GEAR_RATIO.size():
		return 1000.0

	var wheel_circumference : float = 2.0 * PI * RIGHT_REAR_WHEEL_RADIUS
	var wheel_rotation_speed : float = 60.0 * states[STATE.SPEED_MPS] / wheel_circumference
	var drive_shaft_rotation_speed : float = wheel_rotation_speed * FINAL_DRIVE_RATIO

	return max(1000.0, drive_shaft_rotation_speed * GEAR_RATIO[states[STATE.GEAR]])

func _process_gear_inputs(delta : float) -> void:
	if left_gear_shift_time > 0.0:
		left_gear_shift_time = max(0.0, left_gear_shift_time - delta)
		states[STATE.CLUTCH] = 1.0 - left_gear_shift_time / GEAR_SHIFT_TIME
	else:
		if states[STATE.GEAR] > gear_state.REVERSE:
			states[STATE.GEAR] = states[STATE.GEAR] - 1
			left_gear_shift_time = GEAR_SHIFT_TIME
			states[STATE.CLUTCH] = 0.0
			emit_signal(&"gear_changed")
		elif states[STATE.GEAR] < GEAR_RATIO.size():
			states[STATE.GEAR] = states[STATE.GEAR] + 1
			left_gear_shift_time = GEAR_SHIFT_TIME
			states[STATE.CLUTCH] = 0.0
			emit_signal(&"gear_changed")
		else:
			states[STATE.CLUTCH] = 1.0

func _process(delta : float) -> void:
	_process_gear_inputs(delta)

	#var speed : float = get_speed_kph()
	#var rpm : float = calculate_rpm()

	#var info : String = 'Speed: %.0f, RPM: %.0f (gear: %d)'  % [ speed, rpm, states[STATE.GEAR] ]

	#print(info)

func _physics_process(delta : float) -> void:
	# how fast are we going in meters per second?
	states[STATE.SPEED_MPS] = (position - last_position).length() / delta

	# get our joystick inputs
	# var states[STATE.STEER] = inputmap.get_steering_input()
	# var throttle_pos = inputmap.get_throttle_input()
	# var states[STATE.BRAKE] = inputmap.get_brake_input()

	states[STATE.ENGINE_RPM] = calculate_rpm()
	var rpm_factor : float = clamp(states[STATE.ENGINE_RPM] / MAX_ENGINE_RPM, 0.0, 1.0)
	var power_factor : float = POWER_CURVE.sample_baked(rpm_factor)

	engine_force = states[STATE.CLUTCH] * states[STATE.THROTTLE] * power_factor * GEAR_RATIO[int(states[STATE.GEAR])] * FINAL_DRIVE_RATIO * HP

	brake = states[STATE.BRAKE] * BRAKE_FORCE

	var max_steer_speed : float = MAX_STEER_SPEED * 1000.0 / 3600.0
	var steer_speed_factor : float = clamp(states[STATE.SPEED_MPS] / max_steer_speed, 0.0, 1.0)

	if (abs(states[STATE.STEER]) < 0.05):
		states[STATE.STEER] = 0.0
	# elif steer_curve:
	# 	if states[STATE.STEER] < 0.0:
	# 		states[STATE.STEER] = -steer_curve.interpolate_baked(-states[STATE.STEER])
	# 	else:
	# 		states[STATE.STEER] = steer_curve.interpolate_baked(states[STATE.STEER])

	# steer_angle = states[STATE.STEER] * lerp(max_steer_angle_rad, speed_steer_angle_rad, steer_speed_factor)
	steering = -states[STATE.STEER]

	# remember where we are
	last_position = position
