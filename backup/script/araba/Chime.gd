extends AudioStreamPlayer3D
onready var parent = get_parent()
func _ready():
	playing = true
func _process(_delta):
	stream_paused = true if parent.speed < 100 else false

