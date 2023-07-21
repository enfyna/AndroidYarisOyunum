class_name Car
extends VehicleBody3D

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

var throttle_pos : float = 0.0
var brake_pos : float = 0.0
var clutch_pos : float = 1.0

var steer_val : float = 0.0 

var left_gear_shift_time : float = 0.0
var current_gear : int = 2
enum gear_state {
	REVERSE,
	NEUTRAL,
	FORWARD,
}
var current_engine_rpm : float = 0.0
var current_speed_mps : float = 0.0

var last_position : Vector3 = position

func _ready():
	pass

func get_speed_kph() -> float:
	return current_speed_mps * 3.6

# calculate the RPM of our engine based on the current velocity of our car
func calculate_rpm() -> float:
	# if we are in neutral, no rpm
	if current_gear == gear_state.NEUTRAL or current_gear > GEAR_RATIO.size():
		return 1000.0

	var wheel_circumference : float = 2.0 * PI * RIGHT_REAR_WHEEL_RADIUS
	var wheel_rotation_speed : float = 60.0 * current_speed_mps / wheel_circumference
	var drive_shaft_rotation_speed : float = wheel_rotation_speed * FINAL_DRIVE_RATIO

	return max(1000.0, drive_shaft_rotation_speed * GEAR_RATIO[current_gear])

func _process_gear_inputs(delta : float):
	if left_gear_shift_time > 0.0:
		left_gear_shift_time = max(0.0, left_gear_shift_time - delta)
		clutch_pos = 0.0
	else:
		if current_gear > -1:
			current_gear = current_gear - 1
			left_gear_shift_time = GEAR_SHIFT_TIME
			clutch_pos = 0.0
		elif current_gear < GEAR_RATIO.size():
			current_gear = current_gear + 1
			left_gear_shift_time = GEAR_SHIFT_TIME
			clutch_pos = 0.0
		else:
			clutch_pos = 1.0

func _process(delta : float):
	_process_gear_inputs(delta)

	var speed : float = get_speed_kph()
	var rpm : float = calculate_rpm()

	var info : String = 'Speed: %.0f, RPM: %.0f (gear: %d)'  % [ speed, rpm, current_gear ]

	#print(info)

func _physics_process(delta : float):
	# how fast are we going in meters per second?
	current_speed_mps = (position - last_position).length() / delta

	# get our joystick inputs
	# var steer_val = inputmap.get_steering_input()
	# var throttle_pos = inputmap.get_throttle_input()
	# var brake_pos = inputmap.get_brake_input()

	var rpm : float = calculate_rpm()
	var rpm_factor : float = clamp(rpm / MAX_ENGINE_RPM, 0.0, 1.0)
	var power_factor : float = POWER_CURVE.sample_baked(rpm_factor)

	engine_force = clutch_pos * throttle_pos * power_factor * GEAR_RATIO[current_gear] * FINAL_DRIVE_RATIO * HP

	brake = brake_pos * BRAKE_FORCE

	var max_steer_speed : float = MAX_STEER_SPEED * 1000.0 / 3600.0
	var steer_speed_factor : float = clamp(current_speed_mps / max_steer_speed, 0.0, 1.0)

	if (abs(steer_val) < 0.05):
		steer_val = 0.0
	# elif steer_curve:
	# 	if steer_val < 0.0:
	# 		steer_val = -steer_curve.interpolate_baked(-steer_val)
	# 	else:
	# 		steer_val = steer_curve.interpolate_baked(steer_val)

	# steer_angle = steer_val * lerp(max_steer_angle_rad, speed_steer_angle_rad, steer_speed_factor)
	steering = -steer_val

	# remember where we are
	last_position = position
