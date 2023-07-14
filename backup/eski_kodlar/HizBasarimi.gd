extends Node3D
""" var hizbasarimi = Global.Save.get_save()["basarimlar"]["b3"]["ilerleme"]
var topspeed = 100
@onready var parent = get_parent()
func _process(_delta):
	var speed = parent.speed
	if topspeed < speed:
		topspeed = speed
		if speed > 333:
			Global.Save.get_save()["basarimlar"]["b4"]["ilerleme"] += 1
	
			get_tree().change_scene_to_file("res://tscndosyalari/menu/AnaMenu.tscn")
		elif speed > 300 and hizbasarimi == 2:
			Global.Save.get_save()["basarimlar"]["b3"]["ilerleme"] = 3
			hizbasarimi = 3
		elif speed > 200 and hizbasarimi == 1:
			Global.Save.get_save()["basarimlar"]["b3"]["ilerleme"] = 2
			hizbasarimi = 2
		elif speed > 100 and hizbasarimi == 0:
			Global.Save.get_save()["basarimlar"]["b3"]["ilerleme"] = 1
			hizbasarimi = 1
 """
