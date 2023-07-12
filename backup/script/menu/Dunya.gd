extends Control

func _ready():
	if Global.kayit["tutorial"]["giris"] == 7:
		var t = load("res://tscndosyalari/menu/Tutorial.tscn").instance()
		get_parent().get_parent().get_parent().call_deferred("add_child",t)
		Global.kayit["tutorial"]["giris"] += 1
	pass
