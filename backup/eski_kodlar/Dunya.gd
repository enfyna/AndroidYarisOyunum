extends Control

func _ready():
	if Global.Save.get_save()["tutorial"]["giris"] == 8:
		var t = load("res://tscndosyalari/tutorial/Tutorial.tscn").instantiate()
		get_parent().get_parent().get_parent().call_deferred("add_child", t)
		Global.Save.get_save()["tutorial"]["giris"] += 1
	pass
