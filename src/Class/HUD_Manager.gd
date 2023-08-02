class_name HUD_Manager
extends Control

@export var HUD_Selection : HUDS = HUDS.HUD_1

enum HUDS {
	HUD_1,
	#HUD_2, # add later
	#HUD_3, # add later
}

const HUD_SCENE : Dictionary = {
	HUDS.HUD_1 : "res://src/Scenes/HUDs/HUD_1.tscn",
	#HUDS.HUD_2 : "", # add later
}

@export var P_CAR : Car = get_parent()

@onready var P_STATES : Array[float] = P_CAR.states
const GEARS : Array[String] = ["R", "N", "1", "2", "3", "4", "5", "6", "7"]
var MPS_TO_UNIT : float = 3.6 # default to kmh

var C_HUD : HUD

var GAUGES : Array[Node] = []

var ACTIVE_FRAME_GAUGES : Array[int] = []
var ACTIVE_LAP_GAUGES : Array[int] = []

var CAR_GAUGES_NUM : int
func _ready() -> void:
	CAR_GAUGES_NUM = len(P_CAR.STATE)
	GAUGES.resize(CAR_GAUGES_NUM)

	load_HUD()
	bind_HUD()
	pass

func load_HUD() -> void:
	var hud_scene_path : String = HUD_SCENE[HUD_Selection]
	C_HUD = load(hud_scene_path).instantiate()
	add_child(C_HUD)
	pass

func bind_HUD() -> void:
	var dict : Dictionary = C_HUD.car_gauges[HUD.GAUGE_TYPE.FRAME]
	for gauge_type in dict:
		var gauge_node : Node = C_HUD.get_node_or_null(dict[gauge_type])
		if gauge_node == null:
			push_warning("No node path specified for gauge: ", gauge_type)
		else:
			GAUGES[gauge_type] = gauge_node
			ACTIVE_FRAME_GAUGES.append(gauge_type)

	dict = C_HUD.car_gauges[HUD.GAUGE_TYPE.LAP]
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

	dict = C_HUD.car_gauges[HUD.GAUGE_TYPE.SPECIAL]
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
		elif gauge_type == Car.STATE.SPEED_UNIT:
			var is_kmh : bool = Global.Save.get_config().get_value("car","kmh",true)
			if is_kmh:
				gauge_node.text = gauge_node.text + "KMH"
			else:
				gauge_node.text = gauge_node.text + "MPH"
				MPS_TO_UNIT = 2.2

	dict = C_HUD.track_gauges[HUD.GAUGE_TYPE.FRAME]
	for gauge_type in dict:
		var gauge_node : Node = C_HUD.get_node_or_null(dict[gauge_type])
		if gauge_node == null:
			push_warning("No node path specified for gauge: ", dict[gauge_type])
			continue
		if gauge_type == Car.STATE.LAP_TIME:
			GAUGES[gauge_type] = gauge_node
			ACTIVE_FRAME_GAUGES.append(gauge_type)

	dict = C_HUD.track_rewards

	var race_man = P_CAR.get_parent()
	var reward_times = race_man.track.reward_times

	for reward_type in dict:
		var reward_label : Node = C_HUD.get_node_or_null(dict[reward_type])
		if reward_label == null:
			push_warning("No node path specified for reward: ", dict[reward_type])
			continue
		var time : int = reward_times[reward_type]
		reward_label.text = str(str(int(time / 60000.0)).pad_zeros(2),":",str(int((time % 60000) / 1000.0)).pad_zeros(2),":",str(int(time % 1000)).pad_zeros(3))
	pass

func _process(_delta : float) -> void:
	update_frame_gauges()

func update_frame_gauges() -> void:
	for gauge_type in ACTIVE_FRAME_GAUGES:
		var gauge_node : Node = GAUGES[gauge_type]
		match gauge_node.get_class():
			"Label":
				if gauge_type == Car.STATE.GEAR:
					gauge_node.text = GEARS[int(P_STATES[gauge_type])]
				elif gauge_type == Car.STATE.SPEED_MPS:
					gauge_node.text = str(int(P_STATES[gauge_type] * MPS_TO_UNIT))
				elif gauge_type == Car.STATE.LAP_TIME:
					var time : float = P_STATES[gauge_type]
					gauge_node.text = str(str(int(time / 60)).pad_zeros(2),":", str(int(time / 1) % 60).pad_zeros(2),":", str(int(fmod(time, 1) * 1000)).pad_zeros(3))
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
