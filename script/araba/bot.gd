extends VehicleBody3D


@export  var MAX_STEER_ANGLE = 30
@export  var SPEED_STEER_ANGLE = 10
@export  var MAX_STEER_SPEED = 120.0
@onready var max_steer_angle_rad = deg_to_rad(MAX_STEER_ANGLE)
@onready var speed_steer_angle_rad = deg_to_rad(SPEED_STEER_ANGLE)
var steer_angle = 0.0


@export  var MAX_ENGINE_FORCE = 700.0
@export  var MAX_BRAKE_FORCE = 50.0
@export (Array) var gear_ratios = [2.69, 2.01, 1.59, 1.32, 1.13, 1.0]
@export (float) var final_drive_ratio = 3.38
@export (float) var max_engine_rpm = 8000.0
@export (Curve) var power_curve = null
var current_gear = 1
var clutch_position:float = 1.0
var current_speed_mps = 0.0
@onready var last_pos = position
@export  var gear_shift_time = 0.4
var gear_timer = 0.0
func get_speed_kph():
	speed = current_speed_mps * 3600.0 / 1000.0

func calculate_rpm():
	var wheel_circumference:float = 2.0 * PI * ArkaSag.wheel_radius
	var wheel_rotation_speed:float = 60.0 * current_speed_mps / wheel_circumference
	var drive_shaft_rotation_speed:float = wheel_rotation_speed * final_drive_ratio
	if (current_gear <= gear_ratios.size() - 2 or current_gear == - 1) and current_gear != 0:
		if abs(drive_shaft_rotation_speed * gear_ratios[current_gear + 1]) < 1000:
			rpm = 1000.0
		else :
			rpm = drive_shaft_rotation_speed * gear_ratios[current_gear + 1]
	else :
		if drive_shaft_rotation_speed * 2 < 1000.0:
			rpm = 1000.0
		else :
			rpm = drive_shaft_rotation_speed * 2

@onready var hareket = $hareket
@onready var idle = $idle
var rpm = 0
var speed = 0
@onready var player
func _ready():
	add_collision_exception_with(player)
	tekerlekdurum()
	$hareket.playing = true
	$hareket.pitch_scale = 0.3
	$idle.playing = true
	$skid.playing = true
func tekerlekdurum():
	$ArkaSag.wheel_friction_slip = 3.5
	$ArkaSol.wheel_friction_slip = 3.5
	$OnSag.wheel_friction_slip = 3.5
	$OnSol.wheel_friction_slip = 3.5
var n = 1 / gear_shift_time
var vites = 1
var vitesdurum = 0
func _process_gear_inputs(delta:float):
	if vitesdurum > 0:
		n = 1.0 / float(gear_shift_time)
		hareket.volume_db -= (1 - clutch_position) * 10
		if vitesdurum == 1:
			gear_timer -= delta * 2
			clutch_position = abs((gear_timer * n))
			if clutch_position < 0.05:
				current_gear += 1 * vites
				vitesdurum = 2
		elif vitesdurum == 2:
			gear_timer += delta
			clutch_position = abs((gear_timer * n))
			if clutch_position >= 1.0:
				clutch_position = 1.0
				vitesdurum = 0
	else :
		if (rpm < 4000 and current_gear >= 2) and current_gear > - 1:
			vites = - 1
			gear_timer = gear_shift_time
			vitesdurum = 1
		elif (rpm > 6000) and current_gear < gear_ratios.size() - 2:
			vites = 1
			gear_timer = gear_shift_time
			vitesdurum = 1
	$GERI.visible = current_gear == - 1
var kirmizi = true
func _process(delta:float):
	_process_gear_inputs(delta)
	if kirmizi == false:
		harekethesapla()
	idle.volume_db = 10 - speed
	if speed > 15:
		hareket.volume_db = 10
	else :
		hareket.volume_db = - 20 + speed * 2
	if ArkaSag.get_skidinfo() < 0.3:
		skid.volume_db = 10
	else :
		skid.volume_db = - 80

@onready var skid = $skid
@onready var ArkaSag = $ArkaSag
var throttle_val:float
var brake_val:float
var steer_val:float
func _physics_process(delta):
	current_speed_mps = (position - last_pos).length() / delta
	get_speed_kph()
	calculate_rpm()
	
	var rpm_factor = clamp(rpm / max_engine_rpm, 0.0, 1.0)
	hareket.pitch_scale = rpm_factor
	var power_factor = power_curve.interpolate_baked(rpm_factor)
	
	engine_force = clutch_position * throttle_val * power_factor * gear_ratios[current_gear + 1] * final_drive_ratio * MAX_ENGINE_FORCE
	brake = brake_val * MAX_BRAKE_FORCE
	
	var max_steer_speed = MAX_STEER_SPEED * 1000.0 / 3600.0
	var steer_speed_factor = clamp(current_speed_mps / max_steer_speed, 0.0, 1.0)
	steer_angle = steer_val * lerp(max_steer_angle_rad, speed_steer_angle_rad, steer_speed_factor)
	steering = steer_angle
	
	
	last_pos = position

func _on_AE86_1_body_entered(_body):
	$crash.volume_db = (speed / 10)
	$crash.play()
	pass

@onready var fren = $FREN
@onready var front = $RayCastFront
@onready var fleft = $RayCastFrontLeft
@onready var fright = $RayCastFrontRight
func harekethesapla():
	var gaz = front.is_colliding()
	"if gaz:\n		var origin = front.global_transform.origin\n		var collision_point = front.get_collision_point()\n		var distance = origin.distance_to(collision_point) / 40\n		print(distance)\n		if distance > 0.75:\n			throttle_val = 1\n			brake_val = 0\n		elif distance > 0.5:\n			throttle_val = 0.2\n			brake_val = 0.5\n		elif distance > 0.3:\n			throttle_val = 0.0\n			brake_val = 1"
	if gaz and speed > 90:
		brake_val = 1
		fren.visible = true
		throttle_val = 0
	else :
		throttle_val = 1
		brake_val = 0
		fren.visible = false
	if fleft.is_colliding():
		steer_val = lerp(steer_val, - 1, 0.1)
	elif fright.is_colliding():
		steer_val = lerp(steer_val, 1, 0.1)
	else :
		steer_val = lerp(steer_val, 0, 0.1)
	pass
				
				

