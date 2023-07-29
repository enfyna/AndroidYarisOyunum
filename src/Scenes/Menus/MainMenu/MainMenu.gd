extends Menu
@onready var save : Dictionary = Global.Save.get_save()
func _ready() -> void:
	update_selected_car_icon()
	translate_buttons()
func update_selected_car_icon() -> void:
	var selected_car_name : String = save["player"]["car"]
	if selected_car_name.is_empty():
		return
	var selected_car_texture_path : String = "".join(["res://src/Cars/",selected_car_name,"/transparent.png"])
	if selected_car_texture_path.is_absolute_path():
		get_node("hb/araba").texture = load(selected_car_texture_path)