extends VehicleBody
############################################################
# Steering
export var MAX_STEER_ANGLE = 30
export var SPEED_STEER_ANGLE = 10
export var MAX_STEER_SPEED = 120.0
onready var max_steer_angle_rad = deg2rad(MAX_STEER_ANGLE)
onready var speed_steer_angle_rad = deg2rad(SPEED_STEER_ANGLE)
var steer_angle = 0.0
############################################################
# Speed and drive direction
export var MAX_ENGINE_FORCE = 700.0
export var MAX_BRAKE_FORCE = 50.0
export (Array) var gear_ratios = [ 2.69, 2.01, 1.59, 1.32, 1.13, 1.0 ] 
export (float) var final_drive_ratio = 3.38
export (float) var max_engine_rpm = 8000.0
export (Curve) var power_curve = null
var current_gear = 1 # -1 reverse, 0 = neutral, 1 - 6 = gear 1 to 6.
var clutch_position : float = 1.0 # 0.0 = clutch engaged
var current_speed_mps = 0.0
onready var last_pos = translation
export var gear_shift_time = 0.4
var gear_timer = 0.0
func get_speed_kph():
	speed = current_speed_mps * 3600.0 / 1000.0
# calculate the RPM of our engine based on the current velocity of our car
var sabit
func calculate_rpm():
	var drive_shaft_rotation_speed : float = (sabit) * current_speed_mps
	rpm = abs(drive_shaft_rotation_speed * gear_ratios[current_gear+1])
############################################################
onready var hareket = $hareket
onready var idle = $idle
var rpm = 0
var speed = 0
onready var player
var bekle = true
func _ready():
	if typeof(player) == TYPE_OBJECT:
		add_collision_exception_with(player)
		front.add_exception(player)
		fright.add_exception(player)
		fleft.add_exception(player)
	sabit = (60.0/(ArkaSag.wheel_radius * 2.0 * PI))* final_drive_ratio
	tekerlekdurum()
	$hareket.playing = true
	$hareket.pitch_scale =  0.3
	$idle.playing = true
	$skid.playing = true
	ses()
func tekerlekdurum():
	$ArkaSag.wheel_friction_slip = 3.5
	$ArkaSol.wheel_friction_slip = 3.5
	$OnSag.wheel_friction_slip = 3.5
	$OnSol.wheel_friction_slip = 3.5
var n = 1 / gear_shift_time
var vites = 1
var vitesdurum = 0
func _process_gear_inputs(delta : float):
	if vitesdurum > 0:
		n = 1.0 / float(gear_shift_time)
		hareket.unit_db -= (1-clutch_position) * 10
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
		$clutch.value = clutch_position
	else:
		if (rpm < 4000 and current_gear >= 3):
			vites = -1
			gear_timer = gear_shift_time
			vitesdurum = 1
		elif (rpm > 6000) and current_gear < gear_ratios.size()-2:
			vites = 1
			gear_timer = gear_shift_time
			vitesdurum = 1
	$GERI.visible = current_gear == -1
	$rpmbar.value = rpm

func _process(delta):
	_process_gear_inputs(delta)
	if !bekle:
		harekethesapla()
	ses()

func ses():
	idle.unit_db = 10 - speed
	if speed > 15 :
		hareket.unit_db = 10
	else:
		hareket.unit_db = -20 + speed * 2
	if ArkaSag.get_skidinfo() < 0.3:
		skid.unit_db = 10
	else:
		skid.unit_db = -80

onready var skid = $skid
onready var ArkaSag = $ArkaSag
var throttle_val : float
var brake_val : float
var steer_val : float
func _physics_process(delta):
	current_speed_mps = (translation - last_pos).length() / delta
	get_speed_kph()
	calculate_rpm()
	
	var rpm_factor = clamp(rpm / max_engine_rpm, 0.0, 1.0)
	hareket.pitch_scale = max(0.1,rpm_factor)
	var power_factor = power_curve.interpolate_baked(rpm_factor)
	
	engine_force = clutch_position * throttle_val * power_factor * gear_ratios[current_gear+1] * final_drive_ratio * MAX_ENGINE_FORCE
	brake = brake_val * MAX_BRAKE_FORCE
	
	var max_steer_speed = MAX_STEER_SPEED * 1000.0 / 3600.0
	var steer_speed_factor = clamp(current_speed_mps / max_steer_speed, 0.0, 1.0)
	steer_angle = steer_val * lerp(max_steer_angle_rad, speed_steer_angle_rad, steer_speed_factor)
	steering = steer_angle
	
	# remember where we are
	last_pos = translation

func _on_AE86_1_body_entered(_body):
	$crash.unit_db = (speed / 10)
	$crash.play()
	pass

onready var fren = $FREN
onready var front = $node/RayCastFront
func harekethesapla():
	gaz()
	sagsol()
	node.translation.z = -15 + clamp(speed/10-brake_val*5,0,30)
	front.cast_to.z = 5 + speed/10
	$hiz.text = str(int(speed))
func gaz():
	if front.is_colliding() and abs(steer_val) > 0.1:
		brake_val = lerp(brake_val,1,1)
		throttle_val = 0
		fren.visible = true
	else:
		throttle_val = lerp(throttle_val,1,1)
		brake_val = 0
		fren.visible = false
	$gasbar.value = throttle_val
	$frenbar.value = brake_val
onready var node = $node
onready var kutusol = $node/kutusol
onready var kutusag = $node/kutusag
onready var kutuorigin = $node/kutuorigin
onready var kutuorigin2 = $node/kutuorigin2
onready var fleft = $node/RayCastFrontLeft
onready var fright = $node/RayCastFrontRight
var origin  :Vector3
var distancesol = 0
var distancesag = 0
var collision_point : Vector3
var merkez = 0
func sagsol():
	node.global_rotation.z = 0
	origin = fright.global_transform.origin
	kutuorigin2.global_translation = origin
	if fright.is_colliding():
		collision_point = fright.get_collision_point()
		distancesag = (origin.distance_squared_to(collision_point)/50)
		kutusag.global_translation = collision_point
	else:
		distancesag += 0.07
	if fleft.is_colliding():
		collision_point = fleft.get_collision_point()
		distancesol = (origin.distance_squared_to(collision_point)/50)
		kutusol.global_translation = collision_point
	else:
		distancesol += 0.07
	merkez = distancesol - distancesag
	steer_val = clamp(lerp(steer_val,merkez,0.5),-1,1)
	#steer_val = -1 SAG
	#steer_val = 1 SOL
	
"""if gaz:
		var origin = front.global_transform.origin
		var collision_point = front.get_collision_point()
		var distance = origin.distance_to(collision_point) / 40
		print(distance)
		if distance > 0.75:
			throttle_val = 1
			brake_val = 0
		elif distance > 0.5:
			throttle_val = 0.2
			brake_val = 0.5
		elif distance > 0.3:
			throttle_val = 0.0
			brake_val = 1"""


