class_name Car_Controller
extends Node2D

@export var STEERING_MODE : CONTROL_MODE = CONTROL_MODE.ANALOG
@export var SHIFTER_MODE : SHIFT_MODE = SHIFT_MODE.MANUAL

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
	var mode_scene : String = MODE_SCENES[STEERING_MODE]
	var controller : Node = load(mode_scene).instantiate()
	
	add_child(controller)
