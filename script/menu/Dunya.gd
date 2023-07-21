extends Control


func change_scene_global(scene_path : String, args : Array = []) -> void:
	Global.change_scene_with_variable(scene_path, args)
	pass
	

func _ready() -> void:
	pass 
