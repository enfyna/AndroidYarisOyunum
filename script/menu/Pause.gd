extends Control

onready var button = $TextureButton

func _ready():
	button.visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_tree().paused = false
	pass 

func pause():
	button.visible = true
	mouse_filter = Control.MOUSE_FILTER_STOP
	get_tree().paused = true
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT :
		var sahne = str(get_tree().get_current_scene().name)
		if sahne == "Yaris":
			button.visible = true
			mouse_filter = Control.MOUSE_FILTER_STOP
			get_tree().paused = true

func _on_TextureButton_pressed():
	button.visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_tree().paused = false
	
