extends Control

func _on_TestPist_pressed():
	if Global.Save.get_save()["oyuncu"]["seciliaraba"] != "":
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
		var t : Node = load(str("res://tscndosyalari/menu/YarisYukle.tscn")).instantiate()
		t.secilenpist = "res://tscndosyalari/pist/PistTest01.tscn"
		t.mod = "Zaman"
		t.test = true
		t.yaristur = 0
		get_parent().call_deferred("add_child", t)
		call_deferred("free")

func _on_Button_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")

	var silinecek : Node = get_parent().get_parent()
	var t : Node = load("res://tscndosyalari/menu/AnaMenu.tscn").instantiate()
	silinecek.get_parent().call_deferred("add_child",t)
	silinecek.call_deferred("queue_free")
