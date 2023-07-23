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

@onready var P_CAR : Car = get_parent()

@onready var P_STATES : Array[float] = P_CAR.states
const GEARS : Array[String] = ["R", "N", "1", "2", "3", "4", "5", "6"]

var C_HUD : HUD

var GAUGES : Array[Node] = []

var ACTIVE_FRAME_GAUGES : Array[int] = []
var ACTIVE_LAP_GAUGES : Array[int] = []

func _ready() -> void:
	GAUGES.resize(len(P_CAR.STATE))

	load_HUD()
	bind_HUD()
	pass

func load_HUD() -> void:
	var hud_scene_path : String = HUD_SCENE[HUD_Selection]
	C_HUD = load(hud_scene_path).instantiate()
	add_child(C_HUD)
	pass

func bind_HUD() -> void:
	var dict : Dictionary = C_HUD.gauges[HUD.GAUGE_TYPE.FRAME]
	for gauge_type in dict:
		var gauge_node : Node = C_HUD.get_node_or_null(dict[gauge_type])
		if gauge_node == null:
			push_warning("No node path specified for gauge: ", gauge_type)
		else:
			GAUGES[gauge_type] = gauge_node
			ACTIVE_FRAME_GAUGES.append(gauge_type)

	dict = C_HUD.gauges[HUD.GAUGE_TYPE.LAP]
	for gauge_type in dict:
		var gauge_node : Node = C_HUD.get_node_or_null(dict[gauge_type])
		if gauge_node == null:
			push_warning("No node path specified for gauge: ", gauge_type)
			continue
		GAUGES[gauge_type] = gauge_node
		ACTIVE_LAP_GAUGES.append(gauge_type)
	if ACTIVE_LAP_GAUGES.size() > 0:
		P_CAR.completed_lap.connect(update_lap_gauges)
		update_lap_gauges()

	dict = C_HUD.gauges[HUD.GAUGE_TYPE.SPECIAL]
	for gauge_type in dict:
		var gauge_node : Node = C_HUD.get_node_or_null(dict[gauge_type])
		if gauge_node == null:
			push_warning("No node path specified for gauge: ", dict[gauge_type])
			continue
		if gauge_type == Car.STATE.GEAR:
			gauge_node.text = GEARS[int(P_STATES[P_CAR.STATE.GEAR])]
			P_CAR.gear_changed.connect(func():
				gauge_node.text = GEARS[int(P_STATES[P_CAR.STATE.GEAR])]
			)
		elif gauge_type == Car.STATE.WHEEL_TYPE:
			gauge_node.text = str(P_STATES[P_CAR.STATE.WHEEL_TYPE])
			P_CAR.wheel_changed.connect(func():
				gauge_node.text = str(P_STATES[P_CAR.STATE.WHEEL_TYPE])
			)
	pass

func _process(_delta) -> void:
	update_frame_gauges()

func update_frame_gauges() -> void:
	for gauge_type in ACTIVE_FRAME_GAUGES:
		var gauge_node : Node = GAUGES[gauge_type]
		match gauge_node.get_class():
			"Label":
				if gauge_type == Car.STATE.GEAR:
					gauge_node.text = GEARS[int(P_STATES[gauge_type])]
				else:
					gauge_node.text = str(round(P_STATES[gauge_type]))
			"ProgressBar", "TextureProgressBar":
				gauge_node.value = P_STATES[gauge_type]

func update_lap_gauges() -> void:
	for gauge_type in ACTIVE_LAP_GAUGES:
		var gauge_node : Node = GAUGES[gauge_type]
		match gauge_node.get_class():
			"Label":
				gauge_node.text = str(round(P_STATES[gauge_type]))
			"ProgressBar", "TextureProgressBar":
				gauge_node.value = P_STATES[gauge_type]
