extends Control

@onready var save : Dictionary = Global.Save.get_save()

var is_missions_tab_open : bool = false

func _ready():
	var missions_button : Node = get_node("isim")
	missions_button.text = save["player"]["name"]
	missions_button.pressed.connect(toggle_missions_tab)

	var money_tab : Node = get_node("hb")
	for child in money_tab.get_children():
		child.text = str(save["wallet"][child.name])

func toggle_missions_tab():
	var missions_tab : Node = get_node("isim/GorevSekmesi")
	var move_to : int

	if is_missions_tab_open:
		move_to = -missions_tab.size.x
		is_missions_tab_open = false
	else:
		move_to = 0
		is_missions_tab_open = true
	
	var tween : Tween = create_tween()
	tween.tween_property(missions_tab,"position:x",move_to,0.1)
