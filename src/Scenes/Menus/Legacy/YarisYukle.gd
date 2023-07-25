extends TextureRect

@export var loading_bar : Node = null

@export var loading_info_node : Node = null
@export var loading_texts : Array[String] = []
enum text {
	MODE,
	TRACK,
	CAR,
	BOT,
	OK,
}
@export var game_info_node : Node = null
@export var game_info_text : Array[String] = []

var current_mode : RaceManager.MODE = RaceManager.MODE.TIME_TRIAL

const race_manager_path : String = "res://src/Scenes/Menus/Legacy/Yaris.tscn"
var car_path : String = Global.Save.get_save()["player"]["car"]
var track_path : String = "res://src/Tracks/Race/Pist00.tscn"
var bot_path : String = ""

var queue : Array[String] = []

func _ready() -> void:
	set_process(false)

	game_info_node.text = tr(game_info_text.pick_random())

	queue = [race_manager_path,track_path,car_path]

	if current_mode == RaceManager.MODE.RACING:
		queue.append(bot_path)

	for scene in queue:
		ResourceLoader.load_threaded_request(scene)

	set_process(true)
	pass

func _process(_delta):
	var total_load_percentage : float = 0.0

	for scene in queue:
		var scene_load_percentage : Array[float] = []
		var status : int = ResourceLoader.load_threaded_get_status(scene,scene_load_percentage)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			queue.erase(scene)
			if len(queue) == 0:
				load_scenes()
				set_process(false)
				return
			continue
		total_load_percentage += scene_load_percentage[0]
	
	loading_bar.max_value = len(queue)
	loading_bar.value = total_load_percentage

	pass

func load_scenes():
	var race_manager_scene : Node = ResourceLoader.load_threaded_get(race_manager_path).instantiate()

	var track_scene : Node = ResourceLoader.load_threaded_get(track_path).instantiate()
	race_manager_scene.add_child(track_scene)

	var car_scene : Node = ResourceLoader.load_threaded_get(car_path).instantiate()
	race_manager_scene.add_child(car_scene)

	Global.set_current_scene(race_manager_scene)

	pass