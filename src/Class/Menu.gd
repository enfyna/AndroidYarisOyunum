class_name Menu extends Node
@export var translatable_nodes : Array[Node] = []
func translate_buttons() -> void:
	for node in translatable_nodes:
		for group in node.get_groups():
			if group.begins_with("trnslt_"):
				node.text = tr(group.lstrip("trnslt_"))
func change_scene_global(scene_path : String, args : Array = []) -> void:
	Global.change_scene_with_variable(scene_path, args)