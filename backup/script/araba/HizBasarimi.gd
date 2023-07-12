extends Node3D
var hizbasarimi = Global.kayit["basarimlar"]["b3"]["ilerleme"]
var topspeed = 100
@onready var parent = get_parent()
func _process(_delta):
	var speed = parent.speed
	if topspeed < speed:
		topspeed = speed
		if speed > 333:
			Global.kayit["basarimlar"]["b4"]["ilerleme"] += 1
	# warning-ignore:return_value_discarded
			get_tree().change_scene_to_file("res://tscndosyalari/menu/AnaMenu.tscn")
		elif speed > 300 and hizbasarimi == 2:
			Global.kayit["basarimlar"]["b3"]["ilerleme"] = 3
			hizbasarimi = 3
		elif speed > 200 and hizbasarimi == 1:
			Global.kayit["basarimlar"]["b3"]["ilerleme"] = 2
			hizbasarimi = 2
		elif speed > 100 and hizbasarimi == 0:
			Global.kayit["basarimlar"]["b3"]["ilerleme"] = 1
			hizbasarimi = 1
