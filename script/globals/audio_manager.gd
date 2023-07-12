extends Node

var num_players : int = 2
var bus : String = "master"

var available : Array[AudioStreamPlayer] = []
var queue : Array[String] = []

func _ready() -> void:
	background_music_player = AudioStreamPlayer.new()
	add_child(background_music_player)
	background_music_player.finished.connect(_on_background_music_end)
	arkaplanmuzik()

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
var rsayi : int

const musics : Array[String] = [
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Airport Lounge.ogg",
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Deuces.ogg",
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Dirt Rhodes.ogg",
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Hustle.ogg",
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Samba Isobel.ogg",
]

func calinanmuzik() -> String:
	return str(background_music_player.stream.resource_path.split("/")[-1].split(".")[0])

func ackapat(t = null) -> void:
	if t == null:
		var kayit = Global.Save.get_save()
		if kayit["ayarlar"]["muzik"]:
			background_music_player.volume_db = -80 #sesdb
		else:
			background_music_player.volume_db = - 80
	elif t == true:
		background_music_player.volume_db = -80 #sesdb
	else:
		background_music_player.volume_db = -80

func arkaplanmuzik() -> void:
	randomize()
	var rsayiyeni : int = randi() % musics.size()
	while rsayi == rsayiyeni:
		rsayiyeni = randi() % musics.size()

	background_music_player.stream = load(musics[rsayiyeni])
	background_music_player.play()
	rsayi = rsayiyeni

func _on_background_music_end() -> void:
	arkaplanmuzik()
