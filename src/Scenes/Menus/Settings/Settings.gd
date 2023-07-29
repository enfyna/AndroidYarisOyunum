extends Menu
var config : ConfigFile = Global.Save.get_config()
var sections : PackedStringArray = config.get_sections()
func _ready():
	translate_buttons()
	for node in get_tree().get_nodes_in_group("SETTING"):
		find_node_setting(node)

func find_node_setting(node : Node) -> void:
	var node_name : String = node.name
	for section in sections:
		for key in config.get_section_keys(section):
			if node_name == key:
				bind_setting_node(node,section,key)
				return

func bind_setting_node(node,section,key) -> void:
	if node is Button:
		node.button_pressed = config.get_value(section, key, node.name)
		node.pressed.connect(update_setting_choice.bind(section, key, node))
	elif node is Slider:
		node.value = config.get_value(section, key, node.name)
		node.tree_exiting.connect(update_setting_choice.bind(section, key, node))

func update_setting_choice(section : String, key : String, node : Node) -> void:
	if node is Button:
		config.set_value(section, key, node.button_pressed)
	if node is Slider:
		config.set_value(section, key, node.value)

func _exit_tree() -> void:
	Global.Save.save_config(config)
