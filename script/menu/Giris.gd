extends Control
onready var bar = $yuklemebar
onready var tween = $Tween
var tarih

func _ready():
	if OS.get_locale_language() == "tr":
		TranslationServer.set_locale("tr")
	else :
		TranslationServer.set_locale("en")
	
	
	get_tree().set_auto_accept_quit(false)
	tarih = OS.get_date()
	bar.value = 0
	$Tamam.visible = false
	$LineEdit.placeholder_text = tr("g1")
	$LineEdit.visible = false
	kayityukle()

func kayityukle():
	var save_path = "user://save.dat"
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "sifre")
		if error == OK:
			var player_data = file.get_var()
			file.close()
			
			
			var yuzde:float = 100 / player_data.size()
			for idx in range(player_data.size()):
				var key = player_data.keys()[idx]
				if player_data.has(key):
					if typeof(player_data[key]) == TYPE_DICTIONARY:
						for idx2 in range(player_data[key].size()):
							var subkey = player_data[key].keys()[idx2]
							
							if key == "tarih" or key == "gorev":
								tarihayarla(player_data, subkey)
							elif key == "arabalar":
								arabaayarla(player_data, subkey, key)
							elif key == "basarimlar":
								basarimlariayarla(player_data, subkey, key)
							else :
								Global.kayit[key][subkey] = player_data[key][subkey]
					bar.value += yuzde
			
			
			
	else :
		Global.kayit["tarih"]["secilengorev"] = {"1":3, "2":5, "3":7, "4":false, "5":false}
	isimkontrol()
	pass
func tarihayarla(player_data, subkey):
	if subkey == "tarih":
		
		if player_data["tarih"]["tarih"]["day"] < tarih["day"] or player_data["tarih"]["tarih"]["month"] < tarih["month"] or player_data["tarih"]["tarih"]["year"] < tarih["year"]:
			Global.kayit["tarih"]["secilengorev"] = {"1":0, "2":0, "3":0, "4":false, "5":false}
			var rasgele = [0, 0, 0]
			var idx3 = 0
			while rasgele.has(0):
				var rsayi = (randi() % Global.kayit["gorev"].size()) + 1
				if not rasgele.has(rsayi):
					rasgele[idx3] = rsayi
					idx3 += 1
					if idx3 == 3:
						break
			for i in range(3):
				Global.kayit["tarih"]["secilengorev"][str(i + 1)] = rasgele[i]
				Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"][str(i + 1)])]["tamam"] = false
				Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"][str(i + 1)])]["yap"] = 0
		else :
			Global.kayit["tarih"]["secilengorev"] = player_data["tarih"]["secilengorev"]
			if player_data.has("gorev"):
				Global.kayit["gorev"].merge(player_data["gorev"], true)
		Global.kayit["tarih"]["tarih"] = tarih
		pass
	elif subkey == "secilengorev":
		
		pass
	elif subkey == "toplamoynamasure":
		Global.kayit["tarih"]["toplamoynamasure"] = player_data["tarih"]["toplamoynamasure"]
	pass
func arabaayarla(player_data, subkey, key):
	if typeof(player_data[key][subkey]) == TYPE_DICTIONARY:
		for idx3 in range(player_data[key][subkey].size()):
			var subsubkey = player_data[key][subkey].keys()[idx3]
			Global.kayit[key][subkey][subsubkey] = player_data[key][subkey][subsubkey]
	elif typeof(player_data[key][subkey]) == TYPE_INT:
		if player_data[key][subkey] == 1:
			Global.kayit[key][subkey]["sahiplik"] = true
		elif player_data[key][subkey] == 0:
			Global.kayit[key][subkey]["sahiplik"] = false
	pass
func basarimlariayarla(player_data, subkey, key):
	if typeof(player_data[key][subkey]) == TYPE_DICTIONARY:
		for idx3 in range(player_data[key][subkey].size()):
			var subsubkey = player_data[key][subkey].keys()[idx3]
			Global.kayit[key][subkey][subsubkey] = player_data[key][subkey][subsubkey]
	elif typeof(player_data[key][subkey]) == TYPE_INT:
		Global.kayit[key][subkey]["ilerleme"] = player_data[key][subkey]
	pass
func isimkontrol():
	bar.visible = false
	if Global.kayit["oyuncu"]["isim"] == "":
		$LineEdit.visible = true
		$Tamam.text = tr("tamam")
		$Tamam.visible = true
	else :
		ilerle()
func _on_Button_pressed():
	var new_text = $LineEdit.text
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
	else :
		$LineEdit.text = ""
		$LineEdit.placeholder_text = tr("g2")
	pass

func ilerle():
	if Global.kayit["oyuncu"]["isim"] != "":
		Arkaplanmuzik.ackapat()
		var t = load("res://tscndosyalari/menu/AnaMenu.tscn").instance()
		var p = load("res://tscndosyalari/menu/Pause.tscn").instance()
		get_parent().call_deferred("add_child_below_node", get_parent().get_node("/root/Arkaplanmuzik"), t)
		get_parent().call_deferred("add_child_below_node", self, p)
		get_tree().call_deferred("set_current_scene", t)
		tween.interpolate_property(get_node("."), "rect_position", 
		Vector2(0, 0), Vector2(0, 720)
		, 1.5, Tween.TRANS_EXPO, Tween.EASE_OUT, 0.5)
		tween.start()
	else :
		isimkontrol()
	pass
func _on_Tween_tween_completed(_object, _key):
	Global.toplamoynamasuresi()
	call_deferred("free")
	pass






"for i in range(player_data.size()):\n	print(player_data.keys()[i])\nif player_data.has(\"para\"):\n	if player_data[\"para\"].size() == parasayi:\n		Global.para = player_data[\"para\"]\n	else:\n		Global.para = player_data[\"para\"]\n		while Global.para.size() < parasayi:\n			Global.para.append(0)\nelse: #default\n	for _i in range(parasayi):\n		Global.para.append(100)\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n\nif player_data.has(\"arabalar\"):\n	if player_data[\"arabalar\"].size() == arabasayi:\n		Global.sahipolunanarabalar = player_data[\"arabalar\"]\n	else:\n		Global.sahipolunanarabalar = player_data[\"arabalar\"]\n		while Global.sahipolunanarabalar.size() < arabasayi:\n			Global.sahipolunanarabalar.append(0)\nelse: #default\n	#for _i in range(arabasayi):\n		#Global.sahipolunanarabalar.append(0)\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n\nif player_data.has(\"basarimlar\"):\n	if player_data[\"basarimlar\"].size() == basarimsayi:\n		Global.basarimlar = player_data[\"basarimlar\"]\n	else:\n		Global.basarimlar = player_data[\"basarimlar\"]\n		while Global.basarimlar.size() < basarimsayi:\n			Global.basarimlar.append(0)\nelse: #default\n	for _i in range(10):\n		Global.basarimlar.append(0)\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n\nif player_data.has(\"pistler\"):\n	if player_data[\"pistler\"].size() == pistsayi:\n		Global.sahipolunanpistler = player_data[\"pistler\"]\n	else:\n		Global.sahipolunanpistler = player_data[\"pistler\"]\n		while Global.sahipolunanpistler.size() < pistsayi:\n			Global.sahipolunanpistler.append(0)\nelse: #default\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n\nif player_data.has(\"pistsure\"):\n	if player_data[\"pistsure\"].size() == pistsayi:\n		for i in range(pistsayi):\n			var idx = str(\"p\") + str(i)\n			Global.pisteniyisure[idx] = player_data[\"pistsure\"][idx]\n	else:\n		for i in range(pistsayi):\n			var idx = str(\"p\") + str(i)\n			Global.pisteniyisure[idx] = player_data[\"pistsure\"][idx]\n		#while Global.pisteniyisure.size() < pistsayi:\n			#Global.pisteniyisure.append(0)\nelse: #default\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n\nif player_data.has(\"tekerlekler\"):\n	if player_data[\"tekerlekler\"].size() == tekerleksayi:\n		Global.sahipolunantekerlekler = player_data[\"tekerlekler\"]\n	else:\n		Global.sahipolunantekerlekler = player_data[\"tekerlekler\"]\n		while Global.sahipolunantekerlekler.size() < tekerleksayi:\n			Global.sahipolunantekerlekler.append(0)\nelse: #default\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n\nif player_data.has(\"ayarlar\"):\n	if player_data[\"ayarlar\"].size() == ayarlarsayi:\n		Global.ayarlar = player_data[\"ayarlar\"]\n	else:\n		Global.ayarlar = player_data[\"ayarlar\"]\n		while Global.ayarlar.size() < ayarlarsayi:\n			Global.ayarlar.append(0)\nelse: #default\n	Global.ayarlar = [0,1,1,0,1]\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n	\nif player_data.has(\"xp\"):\n	if player_data[\"xp\"].size() == 2:\n		Global.xp = player_data[\"xp\"]\n	else:\n		Global.xp = player_data[\"xp\"]\n		while Global.xp.size() < 2:\n			Global.xp.append(0)\nelse: #default\n	Global.xp = [0,0]\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n\nif player_data.has(\"tutorial\"):\n	if player_data[\"tutorial\"].size() == 1:\n		Global.tutorial = player_data[\"tutorial\"]\n	else:\n		Global.tutorial = player_data[\"tutorial\"]\n		while Global.tutorial.size() < 1:\n			Global.tutorial.append(0)\nelse: #default\n	Global.tutorial = [0] \n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n\nif player_data.has(\"isim\"):\n	Global.isim = player_data[\"isim\"]\nelse:\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n\nif player_data.has(\"secilengorev\"):\n	Global.secilengorev = player_data[\"secilengorev\"]\nelse:\n	Global.secilengorev = {\"1\":0,\"2\":0,\"3\":0,\"4\":false,\"5\":false}\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n\nif player_data.has(\"tarih\"):\n	#print(tarih)\n	#print(player_data[\"tarih\"])\n	if player_data[\"tarih\"][\"day\"]<tarih[\"day\"] or player_data[\"tarih\"][\"month\"]<tarih[\"month\"]or player_data[\"tarih\"][\"year\"]<tarih[\"year\"]:\n		Global.secilengorev = {\"1\":0,\"2\":0,\"3\":0,\"4\":false,\"5\":false}\n		var rasgele = [0,0,0]\n		var idx = 0\n		while rasgele.has(0):\n			var rsayi = randi()%10+1\n			#print(idx)\n			#print(rsayi)\n			#print(rasgele)\n			if not rasgele.has(rsayi):\n				rasgele[idx] = rsayi\n				idx += 1\n				if idx == 3:\n					break\n			#yield(get_tree(), \"idle_frame\")\n		for i in range(3):#Eger gun degistiyse rasgele gorev sec ve ilerlemelerini sifirla\n			Global.secilengorev[str(i+1)] = rasgele[i]\n			Global.gorev[str(Global.secilengorev[str(i+1)])][\"tamam\"] = false\n			Global.gorev[str(Global.secilengorev[str(i+1)])][\"yap\"] = 0\n		print(Global.secilengorev)\n		#print(Global.gorev)\n	else:#Eger gün degismediyse bir sey yapma\n		if player_data.has(\"gorev\"):\n			Global.gorev = player_data[\"gorev\"]\nelse:\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n	pass\nGlobal.tarih = tarih \n\nif player_data.has(\"seciliaraba\"):\n	Global.secilenaraba = player_data[\"seciliaraba\"]\nelse:\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")\n\nif player_data.has(\"zaman\"):\n	Global.oynamasuresi = player_data[\"zaman\"]\nelse:\n	print(\"Kayit dosyasi duzgun yuklenemedi.\")"


"\"#for _i in range(arabasayi):\n			  #Global.sahipolunanarabalar.append(0)\n		for _i in range(pistsayi):\n			  Global.sahipolunanpistler.append(0)\n			  #Global.pisteniyisure.append(0)\n		for _i in range(parasayi):\n			 Global.para.append(100)\n		for _i in range(basarimsayi):\n			  Global.basarimlar.append(0)\n		for _i in range(2):\n			 Global.xp.append(0)\n		Global.tutorial = [0]\n		Global.oynamasuresi = 0\n		Global.tarih = tarih"


