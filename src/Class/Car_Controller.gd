class_name Car_Controller
extends Node2D

@export var P_CAR : Car
var C_CONTR : Node

var SHIFTER_MODE : SHIFT_MODE = SHIFT_MODE.MANUAL
var STEERING_MODE : STEER_MODE = STEER_MODE.DIGITAL

var TWEENS : Array[Tween]
var FUNCTIONS : Array[Callable]

var race_started : bool = false

enum SHIFT_MODE {
	MANUAL,
	AUTOMATIC,
}

enum STEER_MODE {
	DIGITAL,
	ANALOG,
	# AUTOMATIC, # will add this later when I add bots
}

const MODE_SCENES : Dictionary = {
	STEER_MODE.DIGITAL: "res://src/Scenes/Car_Controllers/digital.tscn",
	STEER_MODE.ANALOG: "res://src/Scenes/Car_Controllers/analog.tscn",
	#STEER_MODE.AUTOMATIC: "", #will add this later
}

func _ready():
	set_process(false)
	P_CAR.race_man.race_started.connect(func(): race_started = true)
	var config : ConfigFile = Global.Save.get_config()
	STEERING_MODE = STEER_MODE.ANALOG if config.get_value("car","analog",true) else STEER_MODE.DIGITAL
	SHIFTER_MODE = SHIFT_MODE.MANUAL if config.get_value("car","manual",true) else SHIFT_MODE.AUTOMATIC
	load_controller()
	load_tweens()
	bind_controller()
	if STEERING_MODE:
		FUNCTIONS.append(analog_steering)
	if SHIFTER_MODE:
		FUNCTIONS.append(automatic_shifting)
	if FUNCTIONS.size() > 0:
		set_process(true)

func load_tweens():
	TWEENS.resize(P_CAR.STATE.size())
	TWEENS.fill(null)
	pass

func load_controller():
	var mode_scene : String = MODE_SCENES[STEERING_MODE]
	C_CONTR = load(mode_scene).instantiate()
	call_deferred("add_child", C_CONTR )

func bind_controller():
	for node in C_CONTR.get_children():
		var node_group : Array[StringName] = node.get_groups()
		if "THROTTLE" in node_group:
			node.pressed.connect(func(): lerp_state_to(Car.STATE.THROTTLE, 1.0, 0.5))
			node.released.connect(func(): lerp_state_to(Car.STATE.THROTTLE, 0.0, 0.5))
			continue
		elif "BRAKE" in node_group:
			node.pressed.connect(func(): lerp_state_to(Car.STATE.BRAKE, 1.0, 0.5))
			node.released.connect(func(): lerp_state_to(Car.STATE.BRAKE, 0.0, 0.5))
			continue
		elif "LEFT" in node_group:
			node.pressed.connect(func(): lerp_state_to(Car.STATE.STEER, -1.0, 1.0))
			node.released.connect(func(): lerp_state_to(Car.STATE.STEER, 0.0, 1.0))
			continue
		elif "RIGHT" in node_group:
			node.pressed.connect(func(): lerp_state_to(Car.STATE.STEER, 1.0, 1.0))
			node.released.connect(func(): lerp_state_to(Car.STATE.STEER, 0.0, 1.0))
			continue
		elif "SHIFT_UP" in node_group:
			if SHIFTER_MODE == SHIFT_MODE.AUTOMATIC:
				node.queue_free()
				continue
			node.pressed.connect(func():
				P_CAR.change_gear(int(P_CAR.states[Car.STATE.GEAR]) + 1)
				)
			continue
		elif "SHIFT_DOWN" in node_group:
			if SHIFTER_MODE == SHIFT_MODE.AUTOMATIC:
				node.queue_free()
				continue
			node.pressed.connect(func():
				P_CAR.change_gear(int(P_CAR.states[Car.STATE.GEAR]) - 1)
				)
			continue
		elif "REVERSE" in node_group:
			node.pressed.connect(func():
				P_CAR.change_gear(0 if P_CAR.states[Car.STATE.GEAR] > 0 else 2)
				)
			continue
		elif "CHANGE_CAMERA" in node_group:
			# ADD LATER
			continue
	pass

func lerp_state_to(state : int, final : float, time : float) -> void:
	if not race_started:
		return
	var lsf : Callable = func lerp_state(val):
		P_CAR.states[state] = val
		pass

	var tween : Tween = TWEENS[state]
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_method(lsf, P_CAR.states[state], final, time)
	pass

func analog_steering():
	P_CAR.states[Car.STATE.STEER] = Input.get_accelerometer().normalized().x
	pass

func automatic_shifting():
	var current_gear : int = int(P_CAR.states[Car.STATE.GEAR])

	if current_gear == Car.gear_state.REVERSE:
		return # player is in reverse dont do anything

	var current_rpm : float = P_CAR.states[Car.STATE.ENGINE_RPM]

	var shift_up_rpm : int = 5000
	var shift_down_rpm : int = 3000

	if current_rpm > shift_up_rpm:
		P_CAR.change_gear(current_gear + 1)
	elif current_rpm < shift_down_rpm && current_gear > 2:
		P_CAR.change_gear(current_gear - 1)

	pass

func _process(_delta):
	for f in FUNCTIONS:
		f.call()