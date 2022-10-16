extends Control
onready var bar = $yuklemebar
onready var tween = $Tween
var tarih 

func _ready():
	VisualServer.set_default_clear_color(Color(0.6,1,1,1))
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
			var yuzde : float = 100 / player_data.size()
			for idx in range(player_data.size()):
				var key = player_data.keys()[idx]
				if player_data.has(key):
					if typeof(player_data[key]) == TYPE_DICTIONARY:
						for idx2 in range(player_data[key].size()):
							var subkey = player_data[key].keys()[idx2]
							#print(key,subkey)
							if key == "tarih" or key == "gorev":
								tarihayarla(player_data,subkey)
							elif key == "arabalar":
								arabaayarla(player_data,subkey,key)
							elif key == "basarimlar":
								basarimlariayarla(player_data,subkey,key)
							else:
								Global.kayit[key][subkey] = player_data[key][subkey]
				bar.value += yuzde
	else: #default
		Global.kayit["tarih"]["secilengorev"] = {"1":0,"2":5,"3":7,"4":false,"5":false}
	isimkontrol()
	pass
func tarihayarla(player_data,subkey):
	if subkey == "tarih":
		Global.kayit["tarih"]["secilengorev"] = player_data["tarih"]["secilengorev"]
		if player_data["tarih"]["tarih"]["weekday"] != tarih["weekday"]:
			Global.kayit["tarih"]["secilengorev"]["4"] = false
			Global.kayit["tarih"]["secilengorev"]["5"] = false
			var rasgele = [0,0,0]
			var idx3 = 0
			while rasgele.has(0):
				randomize()
				var rsayi =(randi()%Global.kayit["gorev"].size())
				if (not rasgele.has(rsayi)):
					rasgele[idx3] = rsayi
					idx3 += 1
					if idx3 == 3:
						break
			var gorevsayisi = 3
			for i in range(gorevsayisi):#Eger gun degistiyse rasgele gorev sec ve ilerlemelerini sifirla
				Global.kayit["tarih"]["secilengorev"][str(i+1)] = rasgele[i]
				Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"][str(i+1)])]["tamam"] = false
				Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"][str(i+1)])]["yap"] = 0
		else:#Eger gün degismediyse bir sey yapma
			Global.kayit["tarih"]["secilengorev"] = player_data["tarih"]["secilengorev"]
			if player_data.has("gorev"):
				Global.kayit["gorev"].merge(player_data["gorev"],true)
		Global.kayit["tarih"]["tarih"] = tarih 
		pass
	elif subkey == "secilengorev": #burada birsey yapmana gerek yok
		pass #cunku secilengorevleri yukarida tarih ayarliyor
	elif subkey == "toplamoynamasure":
		Global.kayit["tarih"]["toplamoynamasure"] = player_data["tarih"]["toplamoynamasure"]
	pass
func arabaayarla(player_data,subkey,key):
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
func basarimlariayarla(player_data,subkey,key):
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
	else:
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
	else:
		$LineEdit.text = ""
		$LineEdit.placeholder_text = tr("g2")
	pass

func ilerle():
	if Global.kayit["oyuncu"]["isim"] != "":
		Global.ackapat()
		Global.arkaplanmuzik()
		var t = load("res://tscndosyalari/menu/AnaMenu.tscn").instance()
		var p = load("res://tscndosyalari/menu/Pause.tscn").instance()
		get_parent().call_deferred("add_child_below_node",get_parent().get_node("/root/Global"),t)
		get_parent().call_deferred("add_child_below_node",self,p)
		get_tree().call_deferred("set_current_scene",t)
		tween.interpolate_property(self,"rect_position",
		Vector2(0, 0), Vector2(0, 720)
		,1.5,Tween.TRANS_EXPO, Tween.EASE_OUT,0.5)
		tween.interpolate_property(self,"modulate",
		Color(1,1,1,1),Color(1,1,1,0)
		,1.5,Tween.TRANS_EXPO, Tween.EASE_OUT,0.5)
		tween.start()
	else:
		isimkontrol()
	pass
func _on_Tween_tween_completed(_object, _key):
	Global.toplamoynamasuresi()
	call_deferred("free")
	pass



#var arabasayi = 2
#var pistsayi = 11
#var tekerleksayi = 6
#var parasayi = 5
#var ayarlarsayi = 7
#var basarimsayi = 10
"""for i in range(player_data.size()):
	print(player_data.keys()[i])
if player_data.has("para"):
	if player_data["para"].size() == parasayi:
		Global.para = player_data["para"]
	else:
		Global.para = player_data["para"]
		while Global.para.size() < parasayi:
			Global.para.append(0)
else: #default
	for _i in range(parasayi):
		Global.para.append(100)
	print("Kayit dosyasi duzgun yuklenemedi.")

if player_data.has("arabalar"):
	if player_data["arabalar"].size() == arabasayi:
		Global.sahipolunanarabalar = player_data["arabalar"]
	else:
		Global.sahipolunanarabalar = player_data["arabalar"]
		while Global.sahipolunanarabalar.size() < arabasayi:
			Global.sahipolunanarabalar.append(0)
else: #default
	#for _i in range(arabasayi):
		#Global.sahipolunanarabalar.append(0)
	print("Kayit dosyasi duzgun yuklenemedi.")

if player_data.has("basarimlar"):
	if player_data["basarimlar"].size() == basarimsayi:
		Global.basarimlar = player_data["basarimlar"]
	else:
		Global.basarimlar = player_data["basarimlar"]
		while Global.basarimlar.size() < basarimsayi:
			Global.basarimlar.append(0)
else: #default
	for _i in range(10):
		Global.basarimlar.append(0)
	print("Kayit dosyasi duzgun yuklenemedi.")

if player_data.has("pistler"):
	if player_data["pistler"].size() == pistsayi:
		Global.sahipolunanpistler = player_data["pistler"]
	else:
		Global.sahipolunanpistler = player_data["pistler"]
		while Global.sahipolunanpistler.size() < pistsayi:
			Global.sahipolunanpistler.append(0)
else: #default
	print("Kayit dosyasi duzgun yuklenemedi.")

if player_data.has("pistsure"):
	if player_data["pistsure"].size() == pistsayi:
		for i in range(pistsayi):
			var idx = str("p") + str(i)
			Global.pisteniyisure[idx] = player_data["pistsure"][idx]
	else:
		for i in range(pistsayi):
			var idx = str("p") + str(i)
			Global.pisteniyisure[idx] = player_data["pistsure"][idx]
		#while Global.pisteniyisure.size() < pistsayi:
			#Global.pisteniyisure.append(0)
else: #default
	print("Kayit dosyasi duzgun yuklenemedi.")

if player_data.has("tekerlekler"):
	if player_data["tekerlekler"].size() == tekerleksayi:
		Global.sahipolunantekerlekler = player_data["tekerlekler"]
	else:
		Global.sahipolunantekerlekler = player_data["tekerlekler"]
		while Global.sahipolunantekerlekler.size() < tekerleksayi:
			Global.sahipolunantekerlekler.append(0)
else: #default
	print("Kayit dosyasi duzgun yuklenemedi.")

if player_data.has("ayarlar"):
	if player_data["ayarlar"].size() == ayarlarsayi:
		Global.ayarlar = player_data["ayarlar"]
	else:
		Global.ayarlar = player_data["ayarlar"]
		while Global.ayarlar.size() < ayarlarsayi:
			Global.ayarlar.append(0)
else: #default
	Global.ayarlar = [0,1,1,0,1]
	print("Kayit dosyasi duzgun yuklenemedi.")
	
if player_data.has("xp"):
	if player_data["xp"].size() == 2:
		Global.xp = player_data["xp"]
	else:
		Global.xp = player_data["xp"]
		while Global.xp.size() < 2:
			Global.xp.append(0)
else: #default
	Global.xp = [0,0]
	print("Kayit dosyasi duzgun yuklenemedi.")

if player_data.has("tutorial"):
	if player_data["tutorial"].size() == 1:
		Global.tutorial = player_data["tutorial"]
	else:
		Global.tutorial = player_data["tutorial"]
		while Global.tutorial.size() < 1:
			Global.tutorial.append(0)
else: #default
	Global.tutorial = [0] 
	print("Kayit dosyasi duzgun yuklenemedi.")

if player_data.has("isim"):
	Global.isim = player_data["isim"]
else:
	print("Kayit dosyasi duzgun yuklenemedi.")

if player_data.has("secilengorev"):
	Global.secilengorev = player_data["secilengorev"]
else:
	Global.secilengorev = {"1":0,"2":0,"3":0,"4":false,"5":false}
	print("Kayit dosyasi duzgun yuklenemedi.")

if player_data.has("tarih"):
	#print(tarih)
	#print(player_data["tarih"])
	if player_data["tarih"]["day"]<tarih["day"] or player_data["tarih"]["month"]<tarih["month"]or player_data["tarih"]["year"]<tarih["year"]:
		Global.secilengorev = {"1":0,"2":0,"3":0,"4":false,"5":false}
		var rasgele = [0,0,0]
		var idx = 0
		while rasgele.has(0):
			var rsayi = randi()%10+1
			#print(idx)
			#print(rsayi)
			#print(rasgele)
			if not rasgele.has(rsayi):
				rasgele[idx] = rsayi
				idx += 1
				if idx == 3:
					break
			#yield(get_tree(), "idle_frame")
		for i in range(3):#Eger gun degistiyse rasgele gorev sec ve ilerlemelerini sifirla
			Global.secilengorev[str(i+1)] = rasgele[i]
			Global.gorev[str(Global.secilengorev[str(i+1)])]["tamam"] = false
			Global.gorev[str(Global.secilengorev[str(i+1)])]["yap"] = 0
		print(Global.secilengorev)
		#print(Global.gorev)
	else:#Eger gün degismediyse bir sey yapma
		if player_data.has("gorev"):
			Global.gorev = player_data["gorev"]
else:
	print("Kayit dosyasi duzgun yuklenemedi.")
	pass
Global.tarih = tarih 

if player_data.has("seciliaraba"):
	Global.secilenaraba = player_data["seciliaraba"]
else:
	print("Kayit dosyasi duzgun yuklenemedi.")

if player_data.has("zaman"):
	Global.oynamasuresi = player_data["zaman"]
else:
	print("Kayit dosyasi duzgun yuklenemedi.")"""


""""#for _i in range(arabasayi):
			  #Global.sahipolunanarabalar.append(0)
		for _i in range(pistsayi):
			  Global.sahipolunanpistler.append(0)
			  #Global.pisteniyisure.append(0)
		for _i in range(parasayi):
			 Global.para.append(100)
		for _i in range(basarimsayi):
			  Global.basarimlar.append(0)
		for _i in range(2):
			 Global.xp.append(0)
		Global.tutorial = [0]
		Global.oynamasuresi = 0
		Global.tarih = tarih"""





