extends Control

@onready var kayit : Dictionary = Global.Save.get_save()

@onready var bar : Node = $yuklemebar

#var tarih

func _ready():
	if OS.get_locale_language() == "tr":
		TranslationServer.set_locale("tr")
	else:
		TranslationServer.set_locale("en")

	bar.value = 0
	$Tamam.visible = false
	$LineEdit.placeholder_text = tr("g1")
	$LineEdit.visible = false
	isimkontrol()

func isimkontrol():
	bar.visible = false
	if kayit["oyuncu"]["isim"] == "":
		$LineEdit.visible = true
		$Tamam.text = tr("tamam")
		$Tamam.visible = true
	else:
		ilerle()

func _on_Button_pressed():
	var new_text : String = $LineEdit.text
	isimyaz(new_text)

func _on_LineEdit_text_entered(new_text):
	isimyaz(new_text)

func isimyaz(new_text):
	if new_text.length() > 2:
		kayit["oyuncu"]["isim"] = new_text
		$LineEdit.visible = false
		$Tamam.visible = false
		Global.Save.save_game()
		ilerle()
	else:
		$LineEdit.text = ""
		$LineEdit.placeholder_text = tr("g2")
	pass

func ilerle():
	if kayit["oyuncu"]["isim"] != "":
		var t : Node = load("res://tscndosyalari/menu/AnaMenu.tscn").instantiate()
		get_parent().call_deferred("add_child",t)

		z_index = RenderingServer.CANVAS_ITEM_Z_MAX
		var tween : Tween = create_tween()
		tween.tween_property(
			self, "position:y", 720, 2
			).set_trans(Tween.TRANS_EXPO)
		tween.tween_callback(cikis)

func cikis():
	call_deferred("free")
	pass

	# func kayityukle():
	# 	var save_path = "user://save.dat"

	# 	if FileAccess.file_exists(save_path):
	# 		var file = FileAccess.open(save_path, FileAccess.READ)
	# 		if file != null:
	# 			var player_data = file.get_var()
	# 			file.close()
	# 			var yuzde:float = 100 / player_data.size()
	# 			for idx in range(player_data.size()):
	# 				var key = player_data.keys()[idx]
	# 				if player_data.has(key):
	# 					if typeof(player_data[key]) == TYPE_DICTIONARY:
	# 						for idx2 in range(player_data[key].size()):
	# 							var subkey = player_data[key].keys()[idx2]

	# 							if key == "tarih" or key == "gorev":
	# 								tarihayarla(player_data, subkey)
	# 							elif key == "arabalar":
	# 								arabaayarla(player_data, subkey, key)
	# 							elif key == "basarimlar":
	# 								basarimlariayarla(player_data, subkey, key)
	# 							else:
	# 								kayit[key][subkey] = player_data[key][subkey]
	# 					bar.value += yuzde
	# 	else :
	# 		kayit["tarih"]["secilengorev"] = {"1":3, "2":5, "3":7, "4":false, "5":false}
	# 	isimkontrol()
	# 	pass


	# func tarihayarla(player_data, subkey):
	# 	if subkey == "tarih":

	# 		if player_data["tarih"]["tarih"]["day"] < tarih["day"] or player_data["tarih"]["tarih"]["month"] < tarih["month"] or player_data["tarih"]["tarih"]["year"] < tarih["year"]:
	# 			kayit["tarih"]["secilengorev"] = {"1":0, "2":0, "3":0, "4":false, "5":false}
	# 			var rasgele = [0, 0, 0]
	# 			var idx3 = 0
	# 			while rasgele.has(0):
	# 				var rsayi = (randi() % kayit["gorev"].size()) + 1
	# 				if not rasgele.has(rsayi):
	# 					rasgele[idx3] = rsayi
	# 					idx3 += 1
	# 					if idx3 == 3:
	# 						break
	# 			for i in range(3):
	# 				kayit["tarih"]["secilengorev"][str(i + 1)] = rasgele[i]
	# 				kayit["gorev"][str(kayit["tarih"]["secilengorev"][str(i + 1)])]["tamam"] = false
	# 				kayit["gorev"][str(kayit["tarih"]["secilengorev"][str(i + 1)])]["yap"] = 0
	# 		else :
	# 			kayit["tarih"]["secilengorev"] = player_data["tarih"]["secilengorev"]
	# 			if player_data.has("gorev"):
	# 				kayit["gorev"].merge(player_data["gorev"], true)
	# 		kayit["tarih"]["tarih"] = tarih
	# 		pass
	# 	elif subkey == "secilengorev":

	# 		pass
	# 	elif subkey == "toplamoynamasure":
	# 		kayit["tarih"]["toplamoynamasure"] = player_data["tarih"]["toplamoynamasure"]
	# 	pass


	# func arabaayarla(player_data, subkey, key):
	# 	if typeof(player_data[key][subkey]) == TYPE_DICTIONARY:
	# 		for idx3 in range(player_data[key][subkey].size()):
	# 			var subsubkey = player_data[key][subkey].keys()[idx3]
	# 			kayit[key][subkey][subsubkey] = player_data[key][subkey][subsubkey]
	# 	elif typeof(player_data[key][subkey]) == TYPE_INT:
	# 		if player_data[key][subkey] == 1:
	# 			kayit[key][subkey]["sahiplik"] = true
	# 		elif player_data[key][subkey] == 0:
	# 			kayit[key][subkey]["sahiplik"] = false
	# 	pass


	# func basarimlariayarla(player_data, subkey, key):
	# 	if typeof(player_data[key][subkey]) == TYPE_DICTIONARY:
	# 		for idx3 in range(player_data[key][subkey].size()):
	# 			var subsubkey = player_data[key][subkey].keys()[idx3]
	# 			kayit[key][subkey][subsubkey] = player_data[key][subkey][subsubkey]
	# 	elif typeof(player_data[key][subkey]) == TYPE_INT:
	# 		kayit[key][subkey]["ilerleme"] = player_data[key][subkey]
	# 	pass
