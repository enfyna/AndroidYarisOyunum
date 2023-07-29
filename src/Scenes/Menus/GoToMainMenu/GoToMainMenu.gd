extends TextureButton
func change_scene_global(scene_path : String, args : Array = []) -> void:
	Global.change_scene_with_variable(scene_path, args)
	pass