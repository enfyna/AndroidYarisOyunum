extends VehicleBody
############################################################
# Steering
export var MAX_STEER_ANGLE = 30
export var SPEED_STEER_ANGLE = 10
# warning-ignore:unused_class_variable
export var MAX_STEER_SPEED = 120.0 * 1000.0 / 3600.0
#export var MAX_STEER_INPUT = 90.0
#export var STEER_SPEED = 1.0
# warning-ignore:unused_class_variable
onready var max_steer_angle_rad = deg2rad(MAX_STEER_ANGLE)
# warning-ignore:unused_class_variable
onready var speed_steer_angle_rad = deg2rad(SPEED_STEER_ANGLE)
#onready var max_steer_input_rad = deg2rad(MAX_STEER_INPUT)
#var steer_target = 0.0
var steer_angle = 0.0
################################################################################
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
var sabit
var sabit2
var vitessayisi
onready var last_pos = translation
################################################################################
onready var geri = $GERI
onready var hareket = $hareket
onready var tekerbar = $tekerbar
onready var idle = $idle
onready var crash = $crash
onready var touchgeri = $touchgeri
onready var VitesHUD = $VitesHUD
onready var KMHHUD = $KMHHUD
onready var rpmbar = $rpmbar
onready var gasbar = $gasbar
onready var frenbar = $frenbar
onready var camera = $Camera
onready var clutch = $clutch
onready var absicon = $abs
onready var skid = $skid
onready var ArkaSag = $ArkaSag
onready var steervalbar = $steervalbar
onready var FREN = $FREN
onready var gazpedal
onready var frenpedal
################################################################################
var manuelautoayari = not Global.kayit["ayarlar"]["oto"]
var metremilayari = Global.kayit["ayarlar"]["kmh"]
var girissecenegi = not Global.kayit["ayarlar"]["input"]
var hassasiyet = float(Global.kayit["ayarlar"]["hassasiyet"]) if girissecenegi else float(Global.kayit["ayarlar"]["hassasiyet"]) / 5.0
var hizbasarimi = Global.kayit["basarimlar"]["b3"]["ilerleme"]
var steerlerp = 0;var steer_val = 0
var mss;var msar;var ssar
var kamera = 1
var rpm = 0
var speed = 0
var throttle_val : float
var brake_val : float
var gear_timer = 0.0
var n 
var vites = 1
var vitesdurum = 0 # 0 = basmama durumu 1 = basma durumu 2 = cekme durumu
var yakilanyag = 0
var gearratio_noarray
var tutorial = false
################################################################################
func get_speed_kph(): 
	speed = current_speed_mps * 3.6
	KMHHUD.text = '%d/kmh'%[speed] if not metremilayari else '%d/mph'%[current_speed_mps*2.2]

var drive_shaft_rotation_speed : float
func calculate_rpm() :
	drive_shaft_rotation_speed = (sabit) * current_speed_mps
	rpm = abs(drive_shaft_rotation_speed * gearratio_noarray) # gear_ratios[current_gear+1])
	if rpm < 2000:
		touchgeri.visible = true
		if rpm < 1000:
			rpm = 1000

func _ready():
	if girissecenegi: #Analog // Dijital
		gazpedal = $touchgaz
		frenpedal = $touchfren
		get_node("touchsag").queue_free()
		get_node("touchsol").queue_free()
		get_node("touchfrenkucuk").queue_free()
		get_node("touchgazkucuk").queue_free()
	else:
		gazpedal = $touchgazkucuk
		frenpedal = $touchfrenkucuk
		steervalbar.call_deferred("free")
		get_node("touchfren").queue_free()
		get_node("touchgaz").queue_free()
	if manuelautoayari:
		get_node("touchvitesart").queue_free()
		get_node("touchvitesdus").queue_free()
	if hizbasarimi >= 3:
		$HizBasarimi.queue_free()
	sabit = (60.0/(ArkaSag.wheel_radius * 2.0 * PI))* final_drive_ratio
	n = 1.0 / float(gear_shift_time)
	vitessayisi = gear_ratios.size()-2
	gearratio_noarray = gear_ratios[current_gear+1]
	gasbar.value = 0
	brake_val = 1
	mss = MAX_STEER_SPEED
	msar= max_steer_angle_rad
	ssar= speed_steer_angle_rad
	z = camera.translation.z
	hareket.playing = true
	hareket.pitch_scale =  0.3
	idle.playing = true
	skid.volume_db = -80
	skid.playing = true
	touchgeri.visible = false
	tekerlekdurum(0)
	vitesyaziguncelle()
	motoryagkontrol()
	

export var gear_shift_time : float 
func vitesdegistir(delta : float):
	if vitesdurum > 0:
		clutch.tint_progress = Color(0,0.5,0.5,1)
		hareket.unit_db -= (1-clutch_position) * 10
		if vitesdurum == 1:
			gear_timer -= delta * 2
			clutch_position = abs(gear_timer * n)
			clutch.value = clutch_position
			if clutch_position < 0.05:
				current_gear += 1 * vites
				vitesyaziguncelle()
				vitesdurum = 2
		elif vitesdurum == 2:
			gear_timer += delta
			clutch_position = abs((gear_timer * n))
			clutch.value = clutch_position
			if clutch_position >= 1.0:
				clutch_position = 1.0
				clutch.tint_progress = Color(0,1,1,1)
				vitesdurum = 0
	else:
		if manuelautoayari: #Otomatik
			if  rpm < 3900 and current_gear >= 2:
				vites = -1
				gear_timer = gear_shift_time
				vitesdurum = 1
			elif rpm > 5000 and current_gear < vitessayisi:
				if  rpm > 7000 or abs(drive_shaft_rotation_speed * gear_ratios[current_gear+2]) > 5000:
					vites = 1
					gear_timer = gear_shift_time
					vitesdurum = 1
			elif Input.is_action_just_pressed("reverse"):
				if current_gear != -1:
					current_gear = -1
				else:
					current_gear = 1
				vitesyaziguncelle()
		else:  #Manuel
			if Input.is_action_just_pressed("shift_down") and current_gear > -1:
				vites = -1
				gear_timer = gear_shift_time
				vitesdurum = 1
			elif Input.is_action_just_pressed("shift_up") and current_gear < vitessayisi:
				vites = 1
				gear_timer = gear_shift_time
				vitesdurum = 1
			elif Input.is_action_just_pressed("reverse"):
				if current_gear != -1:
					current_gear = -1
				else:
					current_gear = 1
				vitesyaziguncelle()
func vitesyaziguncelle():
	gearratio_noarray = gear_ratios[current_gear+1]
	if current_gear > 0:
		VitesHUD.text = str(current_gear)
	else:
		VitesHUD.text = 'N' if current_gear == 0 else 'R'
	geri.visible = current_gear == -1
	touchgeri.visible = speed < 20 and current_gear != -1 

func _process(delta):
	calculate_rpm()
	get_speed_kph()
	motorses()
	rpmbarayarla(delta)
	araba()
	################################
	vitesdegistir(delta)
	gaz(delta)
	fren(delta)
	steervaluehesapla()
var z
var konum = "topcamera"
func rpmbarayarla(delta):
	var val = rpmbar.value
	rpmbar.value = lerp(val,rpm,delta*5)
	if val > 6000:
		rpmbar.tint_progress = Color(randf()+0.3,0,0,1)
	else:
		rpmbar.tint_progress = Color(0,rpm/10000+0.4,1,1)
	yakilanyag -= sqrt(rpm)/10000000 #Yag yak
	camera.h_offset = -steer_val / 2
	if geriyebak:
		camera.rotation_degrees.y = 0
	else:
		camera.rotation_degrees.y = 180
	if konum == "topcamera":
		camera.translation.z = z - (speed/200)

func steervaluehesapla():
	if girissecenegi:
		steerlerp = clamp(-1*Input.get_accelerometer().normalized().x,-1,1)
		steervalbar.value = steerlerp
	else:
		if Input.is_action_pressed("ui_left"):
			steerlerp = 1.0
		elif Input.is_action_pressed("ui_right"):
			steerlerp = -1.0
		else:
			steerlerp = 0.0
	steer_val = lerp(steer_val,steerlerp,hassasiyet)
	var steer_speed_factor = clamp(speed / mss, 0.0, 1.0)
	steer_angle = steer_val *lerp(msar,ssar,steer_speed_factor)

func gaz(delta):
	if gazpedal.is_pressed() and not tutorial: 
		if throttle_val < 1:
			throttle_val += delta*4
			gasbar.value = throttle_val
		if throttle_val >= 1:
			throttle_val = 1
	elif throttle_val > 0:
		throttle_val -= delta *4
		gasbar.value = throttle_val
	else:
		throttle_val = 0
func fren(delta):
	if frenpedal.is_pressed() or tutorial:
		if brake_val < 1:
			brake_val += delta*4
			frenbar.value = brake_val
			FREN.visible = true
			absicon.pressed = speed > 1
		if brake_val >= 1:
			brake_val = 1
	elif brake_val > 0:
		brake_val -= delta*4
		frenbar.value = brake_val
		FREN.visible = false
		absicon.pressed = false
	else:
		brake_val = 0
func araba():
	var rpm_factor = clamp(rpm / max_engine_rpm, 0.0, 1.0)
	var power_factor = power_curve.interpolate_baked(rpm_factor)
	engine_force = clutch_position * throttle_val * power_factor \
	* sabit2 * gearratio_noarray#gear_ratios[current_gear+1]
	brake = brake_val * MAX_BRAKE_FORCE
	steering = steer_angle

func motorses():
	idle.unit_db = 10 - speed
	hareket.unit_db = (rpm / 1000) * 2
	hareket.pitch_scale = clamp(rpm / max_engine_rpm, 0.01, 1.0)
	skid.volume_db = 10 if ArkaSag.get_skidinfo() < 0.3 else -80
	pass
func _physics_process(delta):
	current_speed_mps = (translation - last_pos).length() / delta
	last_pos = translation
	
func _on_AE86_1_body_entered(body):
	if body.name != "bot":
		Global.kayit["tekerlekler"]["motor"] -= speed / 100
		get_parent().penalti(0)
	crash.unit_db = (speed / 10)
	crash.play()
	motoryagkontrol()
	pass

func _on_KameraDegistir_pressed():
	if kamera == 1:
		camera.target = $hoodcamera.get_path()
		konum = "hoodcamera"
		$geriyebak.visible = false
		kamera = 2
	elif kamera == 2:
		camera.target = $frontcamera.get_path()
		konum = "frontcamera"
		$geriyebak.visible = false
		kamera = 3
	elif kamera == 3:
		camera.target = $topcamera.get_path()
		konum = "topcamera"
		$geriyebak.visible = true
		kamera = 1
	camera.h_offset = 0
var geriyebak = false
func _on_geriyebak_pressed():
	geriyebak = true
func _on_geriyebak_released():
	geriyebak = false
func motoryagkontrol():
	var motor= 1.0
	if Global.kayit["tekerlekler"]["motor"] > 90:
		motor = 1.0
		$motor.pressed = false
	elif Global.kayit["tekerlekler"]["motor"] > 70:
		motor = 0.9
		$motor.pressed = false
	elif Global.kayit["tekerlekler"]["motor"] > 50:
		motor = 0.8
		$motor.pressed = false
	elif Global.kayit["tekerlekler"]["motor"] > 20:
		motor = 0.5
		$motor.pressed = true
	elif Global.kayit["tekerlekler"]["motor"] > 0:
		motor = 0.1
		$motor.pressed = true
	else:
		motor = 0.0
		$motor.pressed = true
	var yag = 1.0
	if Global.kayit["tekerlekler"]["yag"] > 90:
		$yag.pressed = false
		yag = 1.0
	elif Global.kayit["tekerlekler"]["yag"] > 50:
		$yag.pressed = true
		yag = 0.7
	else:
		$yag.pressed = true
		yag = 0.3
	sabit2 = motor*yag*final_drive_ratio*MAX_ENGINE_FORCE
	pass

func compare_floats(a, b):
	return abs(a - b) <=  0.001 or a > b
func tekerlekdurum(cizgi):
	var tekeryuzde = 0.0
	if compare_floats(Global.kayit["tekerlekler"]["c5"],0.1):
		if cizgi > 0:
			Global.kayit["tekerlekler"]["c5"] -= 0.1
		tekeryuzde = Global.kayit["tekerlekler"]["c5"]
		$tekerbar/tekerdurum.text = "S"
		$tekerbar/tekerdurum.add_color_override("font_color",Color(1,0,0,1))
		$ArkaSag.wheel_friction_slip = 3.5
		$ArkaSol.wheel_friction_slip = 3.5
		$OnSag.wheel_friction_slip = 3.5
		$OnSol.wheel_friction_slip = 3.5
	elif compare_floats(Global.kayit["tekerlekler"]["c3"],0.05):
		if cizgi > 0:
			Global.kayit["tekerlekler"]["c3"] -= 0.05
		tekeryuzde = Global.kayit["tekerlekler"]["c3"]
		$tekerbar/tekerdurum.text = "M"
		$tekerbar/tekerdurum.add_color_override("font_color",Color(1,1,0,1))
		$ArkaSag.wheel_friction_slip = 2.83
		$ArkaSol.wheel_friction_slip = 2.83
		$OnSag.wheel_friction_slip = 2.83
		$OnSol.wheel_friction_slip = 2.83
	elif compare_floats(Global.kayit["tekerlekler"]["c1"],0.04):
		if cizgi > 0:
			Global.kayit["tekerlekler"]["c1"] -= 0.04
		tekeryuzde = Global.kayit["tekerlekler"]["c1"]
		$tekerbar/tekerdurum.text = "H"
		$tekerbar/tekerdurum.add_color_override("font_color",Color(1,1,1,1))
		$ArkaSag.wheel_friction_slip = 2.15
		$ArkaSol.wheel_friction_slip = 2.15
		$OnSag.wheel_friction_slip = 2.15
		$OnSol.wheel_friction_slip = 2.15
	elif compare_floats(Global.kayit["tekerlekler"]["konfor"],0.02):
		if cizgi > 0:
			Global.kayit["tekerlekler"]["konfor"] -= 0.02
		tekeryuzde = Global.kayit["tekerlekler"]["konfor"]
		$tekerbar/tekerdurum.text = "K"
		$tekerbar/tekerdurum.add_color_override("font_color",Color(0.4,0.4,0.4,1))
		$ArkaSag.wheel_friction_slip = 1.53
		$ArkaSol.wheel_friction_slip = 1.53
		$OnSag.wheel_friction_slip = 1.53
		$OnSol.wheel_friction_slip = 1.53
	else:
		tekeryuzde = 0
		$tekerbar/tekerdurum.text = "E"
		$tekerbar/tekerdurum.add_color_override("font_color",Color(0,0,0,1))
		$ArkaSag.wheel_friction_slip = 1
		$ArkaSol.wheel_friction_slip = 1
		$OnSag.wheel_friction_slip = 1
		$OnSol.wheel_friction_slip = 1
	var stylbx = tekerbar.get_stylebox("fg").duplicate()
	tekeryuzde = fmod(tekeryuzde,1) if tekeryuzde != 1.0 else 1.0
	if tekeryuzde >= 0.5:
		stylbx.bg_color = Color(0,1,0,0.5)
		tekerbar.add_stylebox_override("fg",stylbx)
	elif tekeryuzde >= 0.2:
		stylbx.bg_color = Color(1,1,0,0.5)
		tekerbar.add_stylebox_override("fg",stylbx)
	else:
		stylbx.bg_color = Color(1,0,0,0.5)
		tekerbar.add_stylebox_override("fg",stylbx)
	tekerbar.value =  tekeryuzde
	Global.kayit["tekerlekler"]["yag"] += yakilanyag
	yakilanyag = 0




