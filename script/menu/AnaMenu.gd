extends Control

@onready var save = Global.Save.get_save()

const NO_CAR_SELECTED_TEXTURE : String = "res://resimler/menu/garaj/bos.png"

func change_scene_with_variable(scene_path : String, args : Array = []) -> void:
	Global.Audio.play("res://muzik/uisounds/clicksound.ogg")
	var scene : Node = load(scene_path).instantiate()
	for arg in args:
		scene.set(arg[0],arg[1])
	get_parent().call_deferred("add_child", scene)
	call_deferred("queue_free")

func _ready() -> void:
	translate_buttons()
	update_selected_car_icon()

func translate_buttons() -> void:
	var grid : Node = get_node("hb/gc")
	for node in grid.get_children():
		var child : Node = node.get_child(0)
		if typeof(child) != typeof(Button):
			continue
		for group in child.get_groups():
			if group.begins_with("trnslt_"):
				child.text = tr(group.erase(0, 7))

func update_selected_car_icon():
	var car : String = save["player"]["car"]
	if car.is_empty():
		get_node("hb/araba").texture = load(NO_CAR_SELECTED_TEXTURE)
	else:
		car.erase(0, 26)
		car.erase(max(0,car.length() - 5), 5)
		car = car.to_lower()
		var selected_car : String = "".join(["res://resimler/menu/garaj/",car,"t.png"])
		get_node("hb/araba").texture = load(selected_car)
