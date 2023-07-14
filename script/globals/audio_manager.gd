class_name AudioManager
extends Node

var num_players : int = 2
var bus : String = "master"

var available : Array[AudioStreamPlayer] = []
var queue : Array[String] = []

func _ready() -> void:
	background_music_player = AudioStreamPlayer.new()
	add_child(background_music_player)
	background_music_player.finished.connect(_on_background_music_end)
	play_new_background_music()

	for i in num_players:
		var p : AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = bus

func _on_stream_finished(stream) -> void:
	available.append(stream)
	check_sounds_to_play()

func play(sound_path) -> void:
	queue.append(sound_path)
	check_sounds_to_play()

func check_sounds_to_play() -> void:
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()

###

@onready var background_music_player : AudioStreamPlayer
var sesdb : int = 0
var selected_music_idx : int

const musics : Array[String] = [
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Airport Lounge.ogg",
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Deuces.ogg",
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Dirt Rhodes.ogg",
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Hustle.ogg",
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Samba Isobel.ogg",
]

func get_played_music() -> String:
	return str(background_music_player.stream.resource_path.split("/")[-1].split(".")[0])

func play_background_music(choice = null) -> void:
	if choice == null:
		var save = Global.Save.get_save()
		if save["ayarlar"]["muzik"]:
			background_music_player.volume_db = -80 #sesdb
		else:
			background_music_player.volume_db = - 80
	elif choice == true:
		background_music_player.volume_db = -80 #sesdb
	else:
		background_music_player.volume_db = -80

func play_new_background_music() -> void:
	randomize()
	var new_music_idx : int = randi() % musics.size()
	while selected_music_idx == new_music_idx:
		new_music_idx = randi() % musics.size()

	background_music_player.stream = load(musics[new_music_idx])
	background_music_player.play()
	selected_music_idx = new_music_idx

func _on_background_music_end() -> void:
	play_new_background_music()
