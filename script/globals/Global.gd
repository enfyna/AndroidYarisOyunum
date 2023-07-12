extends Control

var Save : SaveManager = SaveManager.new()

func oyunkaydet():
	Save.save_game()

func oyuncuseviye(m):
	var kayit : Dictionary = Save.get_save()
	if (kayit["oyuncu"]["lvl"] - (kayit["oyuncu"]["lvl"] % 10)) / 10 >= 1:
		kayit["oyuncu"]["xp"] += (m * 5) / ((kayit["oyuncu"]["lvl"] - (kayit["oyuncu"]["lvl"] % 10)) / 10)
	else:
		kayit["oyuncu"]["xp"] += m * 5

	while kayit["oyuncu"]["xp"] >= 500:
		kayit["oyuncu"]["lvl"] += 1
		kayit["oyuncu"]["xp"] -= 500
		kayit["para"]["para"] += kayit["oyuncu"]["lvl"] * 100

# func toplamoynamasuresi():
# 	var _err = get_tree().create_timer(5).timeout.connect(surearttir)

# func surearttir():
# 	var kayit : Dictionary = Save.get_save()
# 	kayit["tarih"]["toplamoynamasure"] += 5000
# 	toplamoynamasuresi()


# func _notification(what):
# 	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST) and get_tree().get_current_scene() != null:
# 		var sahne = str(get_tree().get_current_scene().name)
# 		if sahne != "AnaMenu" and (sahne != "Yaris") and (sahne != "Giris") and (sahne != "YarisBitir"):
# 			var silinecek = get_tree().get_current_scene()
# 			var t = load("res://tscndosyalari/menu/AnaMenu.tscn").instantiate()
# 			get_parent().call_deferred("add_sibling", get_node("/root/Arkaplanmuzik"), t)

# 			get_tree().call_deferred("set_current_scene", t)

# 			silinecek.call_deferred("free")
# 		elif sahne == "AnaMenu":
# 			oyunkaydet()
# 			var t = load("res://tscndosyalari/menu/Cikis.tscn").instantiate()
# 			get_parent().call_deferred("add_child", t)
# 		elif sahne == "Yaris":
# 			get_parent().get_node("/root/Pause").pause()
# 			pass
