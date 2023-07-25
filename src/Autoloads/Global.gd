extends Control

var Save : SaveManager = SaveManager.new()
var Audio : AudioManager

func _ready():
	Audio = AudioManager.new()
	add_child(Audio)

	if OS.get_locale_language() == "tr":
		TranslationServer.set_locale("tr")
	else:
		TranslationServer.set_locale("en")
	
	pass

var current_scene : Node = null
func change_scene_with_variable(scene_path : String, args : Array = []) -> void:
	Global.Audio.play("res://src/Sounds/UI/Click.ogg")

	ResourceLoader.load_threaded_request(scene_path,"PackedScene",true)

	while ResourceLoader.load_threaded_get_status(scene_path) != ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().create_timer(0.1).timeout

	var scene : Node = ResourceLoader.load_threaded_get(scene_path).instantiate()
	for arg in args:
		scene.set(arg[0],arg[1])

	set_current_scene(scene)
	pass

func set_current_scene(scene_node : Node):
	get_parent().call_deferred("add_child", scene_node)
	
	if current_scene:
		current_scene.call_deferred("queue_free")
	
	current_scene = scene_node
	pass