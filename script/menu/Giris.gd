extends Control

@onready var ok_button : Node = get_node("ok")
@onready var name_box : Node = get_node("name")

var save : Dictionary = Global.Save.get_save()

func _ready() -> void:
	if not save["player"]["name"].is_empty():
		go_to_main_menu()
		return
	ok_button.text = tr("tamam")
	ok_button.pressed.connect(check_user_name)
	name_box.text_submitted.connect(check_user_name)

func check_user_name(user_name : String = ""):
	if user_name.is_empty():
		user_name = name_box.text.strip_edges(true, true)
	if not is_valid_user_name(user_name):
		name_box.text = ""
		name_box.placeholder_text = tr("g2")
		return
	save["player"]["name"] = user_name
	Global.Save.save_game()
	go_to_main_menu()

func is_valid_user_name(user_name : String):
	if user_name.length() < 2:
		return false
	if not user_name.is_valid_identifier():
		return false
	return true

func go_to_main_menu():
	name_box.visible = false
	ok_button.visible = false

	var Main_Menu_Scene : Node = preload("res://tscndosyalari/menu/AnaMenu.tscn").instantiate() 

	get_parent().call_deferred("add_child",Main_Menu_Scene)

	self.z_index = RenderingServer.CANVAS_ITEM_Z_MAX
	var tween : Tween = create_tween()
	tween.tween_property(
		self, "position:y", size.y, 2
		).set_trans(Tween.TRANS_EXPO)
	tween.tween_callback(func(): queue_free())
