class_name HUD_Manager
extends Control

@export var HUD_Selection : HUD_TYPES = HUD_TYPES.HUD_1

enum HUD_TYPES {
	HUD_1,
	HUD_2, # add later
	#HUD_3, # add later
}

const HUD_SCENE : Dictionary = {
	HUD_TYPES.HUD_1 : "res://tscndosyalari/araba_hud/HUD_1.tscn",
	#HUD_TYPES.HUD_2 : "", # add later
}

@onready var CAR : Car = get_parent()

const GEARS : Array[String] = ["R", "N", "1", "2", "3", "4", "5", "6"]

var C_HUD : HUD 

func _ready() -> void:
	load_HUD()

	pass

func load_HUD():
	var hud_scene_path : String = HUD_SCENE[HUD_Selection]
	C_HUD = load(hud_scene_path).instantiate()
	add_child(C_HUD)

	print(C_HUD.gauges)
	print("huh")
	print(CAR)
	pass
