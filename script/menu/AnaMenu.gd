extends Control

@export var translatable_nodes : Array[Node] = []

@onready var save : Dictionary = Global.Save.get_save()

const NO_CAR_SELECTED_TEXTURE : String = "res://resimler/menu/garaj/bos.png"

func change_scene_global(scene_path : String, args : Array = []) -> void:
	Global.change_scene_with_variable(scene_path, args)
	pass
	
func _ready() -> void:
	translate_buttons()
	update_selected_car_icon()
		
func translate_buttons() -> void:
	for node in translatable_nodes:
		for group in node.get_groups():
			if group.begins_with("trnslt_"):
				node.text = tr(group.lstrip("trnslt_"))

func update_selected_car_icon() -> void:
	var selected_car_path : String = save["player"]["car"]
	if selected_car_path.is_empty():
		get_node("hb/araba").texture = load(NO_CAR_SELECTED_TEXTURE)
	else:
		var selected_car_name : String = selected_car_path.split("/")[-1].split(".")[0].to_lower()
		var selected_car_texture_path : String = "".join(["res://resimler/menu/garaj/",selected_car_name,"t.png"])
		if selected_car_texture_path.is_absolute_path():
			get_node("hb/araba").texture = load(selected_car_texture_path)
