extends Control

@onready var save = Global.Save.get_save()

const NO_CAR_SELECTED_TEXTURE : String = "res://resimler/menu/garaj/bos.png"

func change_scene_with_variable(scene_path : String, args : Array = []) -> void:
	Global.Audio.play("res://muzik/uisounds/clicksound.ogg")

	ResourceLoader.load_threaded_request(scene_path,"PackedScene",true)

	while ResourceLoader.load_threaded_get_status(scene_path) != ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().create_timer(0.1).timeout

	var scene : Node = ResourceLoader.load_threaded_get(scene_path).instantiate()
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
		var child : Button = node.get_child(0)
		for group in child.get_groups():
			if group.begins_with("trnslt_"):
				child.text = tr(group.erase(0, 7))

func update_selected_car_icon():
	var car : String = save["player"]["car"]
	if car.is_empty():
		get_node("hb/araba").texture = load(NO_CAR_SELECTED_TEXTURE)
	else:
		car = car.split("/")[-1].left(car.length() - 5)
		var selected_car : String = "".join(["res://resimler/menu/garaj/",car,"t.png"])
		get_node("hb/araba").texture = load(selected_car)
