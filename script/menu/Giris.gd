extends Control

@onready var bar = $yuklemebar

var tarih

func _ready():
	if OS.get_locale_language() == "tr":
		TranslationServer.set_locale("tr")
	else:
		TranslationServer.set_locale("en")

	# get_tree().set_auto_accept_quit(false)
	tarih = Time.get_date_dict_from_system()
	bar.value = 0
	$Tamam.visible = false
	$LineEdit.placeholder_text = tr("g1")
	$LineEdit.visible = false
	isimkontrol()


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
# 								Global.kayit[key][subkey] = player_data[key][subkey]
# 					bar.value += yuzde
# 	else :
# 		Global.kayit["tarih"]["secilengorev"] = {"1":3, "2":5, "3":7, "4":false, "5":false}
# 	isimkontrol()
# 	pass


# func tarihayarla(player_data, subkey):
# 	if subkey == "tarih":

# 		if player_data["tarih"]["tarih"]["day"] < tarih["day"] or player_data["tarih"]["tarih"]["month"] < tarih["month"] or player_data["tarih"]["tarih"]["year"] < tarih["year"]:
# 			Global.kayit["tarih"]["secilengorev"] = {"1":0, "2":0, "3":0, "4":false, "5":false}
# 			var rasgele = [0, 0, 0]
# 			var idx3 = 0
# 			while rasgele.has(0):
# 				var rsayi = (randi() % Global.kayit["gorev"].size()) + 1
# 				if not rasgele.has(rsayi):
# 					rasgele[idx3] = rsayi
# 					idx3 += 1
# 					if idx3 == 3:
# 						break
# 			for i in range(3):
# 				Global.kayit["tarih"]["secilengorev"][str(i + 1)] = rasgele[i]
# 				Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"][str(i + 1)])]["tamam"] = false
# 				Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"][str(i + 1)])]["yap"] = 0
# 		else :
# 			Global.kayit["tarih"]["secilengorev"] = player_data["tarih"]["secilengorev"]
# 			if player_data.has("gorev"):
# 				Global.kayit["gorev"].merge(player_data["gorev"], true)
# 		Global.kayit["tarih"]["tarih"] = tarih
# 		pass
# 	elif subkey == "secilengorev":

# 		pass
# 	elif subkey == "toplamoynamasure":
# 		Global.kayit["tarih"]["toplamoynamasure"] = player_data["tarih"]["toplamoynamasure"]
# 	pass


# func arabaayarla(player_data, subkey, key):
# 	if typeof(player_data[key][subkey]) == TYPE_DICTIONARY:
# 		for idx3 in range(player_data[key][subkey].size()):
# 			var subsubkey = player_data[key][subkey].keys()[idx3]
# 			Global.kayit[key][subkey][subsubkey] = player_data[key][subkey][subsubkey]
# 	elif typeof(player_data[key][subkey]) == TYPE_INT:
# 		if player_data[key][subkey] == 1:
# 			Global.kayit[key][subkey]["sahiplik"] = true
# 		elif player_data[key][subkey] == 0:
# 			Global.kayit[key][subkey]["sahiplik"] = false
# 	pass


# func basarimlariayarla(player_data, subkey, key):
# 	if typeof(player_data[key][subkey]) == TYPE_DICTIONARY:
# 		for idx3 in range(player_data[key][subkey].size()):
# 			var subsubkey = player_data[key][subkey].keys()[idx3]
# 			Global.kayit[key][subkey][subsubkey] = player_data[key][subkey][subsubkey]
# 	elif typeof(player_data[key][subkey]) == TYPE_INT:
# 		Global.kayit[key][subkey]["ilerleme"] = player_data[key][subkey]
# 	pass


func isimkontrol():
	bar.visible = false
	if Global.kayit["oyuncu"]["isim"] == "":
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
		Global.kayit["oyuncu"]["isim"] = new_text
		Global.oyunkaydet()
		$LineEdit.visible = false
		$Tamam.visible = false
		ilerle()
	else:
		$LineEdit.text = ""
		$LineEdit.placeholder_text = tr("g2")
	pass

func ilerle():
	if Global.kayit["oyuncu"]["isim"] != "":
		Arkaplanmuzik.ackapat()
		var t : Node = load("res://tscndosyalari/menu/AnaMenu.tscn").instantiate()
		var p : Node = load("res://tscndosyalari/menu/Pause.tscn").instantiate()
		get_parent().call_deferred("add_sibling", get_parent().get_node("/root/Arkaplanmuzik"), t)
		get_parent().call_deferred("add_sibling", self, p)
		get_tree().call_deferred("set_current_scene", t)
		
		var tween : Tween = create_tween()
		tween.tween_property(
			self, "position", Vector2(0, 720), 1.5
		).set_trans(Tween.TRANS_EXPO)
		tween.tween_callback(cikis)
	else:
		isimkontrol()

func cikis():
	Global.toplamoynamasuresi()
	call_deferred("free")
	pass

