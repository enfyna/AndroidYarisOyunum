class_name Car_Controller
extends Node2D

@export var STEERING_MODE : CONTROL_MODE = CONTROL_MODE.DIGITAL
@export var SHIFTER_MODE : SHIFT_MODE = SHIFT_MODE.MANUAL

@export var P_CAR : Car 

var C_CONTR : Node

var TWEENS : Array[Tween]

enum SHIFT_MODE {
	MANUAL,
	AUTOMATIC,
}

enum CONTROL_MODE {
	DIGITAL,
	ANALOG,
	# AUTOMATIC, # will add this later when I add bots
}

const MODE_SCENES : Dictionary = {
	CONTROL_MODE.DIGITAL: "res://tscndosyalari/araba_kontrol/digital.tscn",
	CONTROL_MODE.ANALOG: "res://tscndosyalari/araba_kontrol/analog.tscn",
	#CONTROL_MODE.AUTOMATIC: "res://tscndosyalari/araba_kontrol/automatic.tscn", #will add this later
}

func _ready():
	load_controller()
	load_tweens()
	bind_controller()

func load_tweens():
	TWEENS.resize(P_CAR.STATE.size())
	TWEENS.fill(null)
	pass

func load_controller():
	var mode_scene : String = MODE_SCENES[STEERING_MODE]
	C_CONTR = load(mode_scene).instantiate()
	add_child(C_CONTR)

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
			node.pressed.connect(func(): 
				P_CAR.change_gear(int(P_CAR.states[Car.STATE.GEAR]) + 1)
				)
			continue
		elif "SHIFT_DOWN" in node_group:
			node.pressed.connect(func(): 
				P_CAR.change_gear(int(P_CAR.states[Car.STATE.GEAR]) - 1)
				)
			continue
		elif "REVERSE" in node_group:
			node.pressed.connect(func(): 
				P_CAR.change_gear(1)
				)
			continue
		elif "CHANGE_CAMERA" in node_group:
			# ADD LATER
			continue
	pass

func lerp_state_to(state : int, final : float, time : float) -> void:
	var lsf : Callable = func lerp_state(val):
		P_CAR.states[state] = val
		pass

	var tween : Tween = TWEENS[state]
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_method(lsf, P_CAR.states[state], final, time)
	pass
