extends Node

var num_players = 2
var bus = "master"

var available = []
var queue = []


func _ready():
	
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.connect("finished", Callable(self, "_on_stream_finished").bind(p))
		p.bus = bus


func _on_stream_finished(stream):
	
	available.append(stream)


func play(sound_path):
	queue.append(sound_path)


func _process(_delta):
	
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()
