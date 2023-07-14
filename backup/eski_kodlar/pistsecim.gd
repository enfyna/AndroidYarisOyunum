extends Control

var pistsayisi = 11
var arabastr
var i = 0
var mod
var secilentursayisi = 3
var bonus = 900
var kayit : Dictionary

func _ready():
	kayit = Global.Save.get_save()
	bonus = pow(secilentursayisi, 2) * 100
	$TurSayisi / h / Bonus.text = tr("bonus") + " : " + str(bonus) + " " + tr("para")
	var pistnode
	var surenode
	var butonnode
	for x in range(pistsayisi):
		var id = kayit["pistler"].keys()[x]
		pistnode = str("HScrollBar/HBoxContainer/" + str(id))
		surenode = str(pistnode + "/sutun1/Container2/sure")
		butonnode = str(pistnode + "/sutun1/Container2/Button")
		if kayit["pistler"][id] == 1:
			get_node(butonnode).text = tr("git")
			get_node(pistnode).visible = 1
			var z = kayit["pistsure"][id]
			if z != 0:
				var ms = int(z % 1000)
				var saniye = int((z / 1000) % 60)
				var dakika = int((z / 60000) % 60)
				var gecenzaman = "%d:%02d:%02d" % [dakika, saniye, ms]
				get_node(surenode).text = str(gecenzaman)
			else :
				get_node(surenode).text = str("---")
		else :
			get_node(pistnode).queue_free()
			
	
	if kayit["oyuncu"]["seciliaraba"] != "":
		arabastr = str(kayit["oyuncu"]["seciliaraba"])
		arabastr.erase(0, 26)
		arabastr.erase(arabastr.length() - 5, 5)
		$secilenaraba.text = tr("secilenaraba") + " : " + arabastr
		$secilenaraba.add_theme_color_override("font_color", Color(1, 1, 1, 1))
		i = 1
	else :
		$secilenaraba.text = tr("arabayok")
		$secilenaraba.add_theme_color_override("font_color", Color(1, 0, 0, 1))
		i = 0
	if mod == "Zaman":
		$TurSayisi.visible = false
	elif mod == "Yaris":
		$TurSayisi / h / Tur.text = str(secilentursayisi) + " " + tr("tur")
	pass

func _on_Arttir_pressed():
	if secilentursayisi < 7:
		secilentursayisi += 1
		bonus = pow(secilentursayisi, 2) * 100
		$TurSayisi / h / Bonus.text = tr("bonus") + " : " + str(bonus) + " " + tr("para")
		$TurSayisi / h / Tur.text = str(secilentursayisi) + " " + tr("tur")
	pass

func _on_Azalt_pressed():
	if secilentursayisi > 3:
		secilentursayisi -= 1
		bonus = pow(secilentursayisi, 2) * 100
		$TurSayisi / h / Bonus.text = tr("bonus") + " : " + str(bonus) + " " + tr("para")
	$TurSayisi / h / Tur.text = str(secilentursayisi) + " " + tr("tur")
	pass

func pistegit(index):
	i = 0
	var secilenpist = "res://tscndosyalari/pist/Pist" + str(index) + ".tscn"
	var t = load(str("res://tscndosyalari/menu/YarisYukle.tscn")).instantiate()
	t.mod = mod
	t.secilenpist = secilenpist
	t.yaristur = secilentursayisi
	t.kazanmabonusu = bonus
	get_parent().add_child(t)
	call_deferred("free")
	pass

func _on_Button1_pressed():
	if i == 1:
		pistegit("01")
	pass

func _on_Button2_pressed():
	if i == 1:
		pistegit("02")
	pass

func _on_Button3_pressed():
	if i == 1:
		pistegit("03")
	pass

func _on_Button4_pressed():
	if i == 1:
		pistegit("04")
	pass

func _on_Button5_pressed():
	if i == 1:
		pistegit("05")
	pass

func _on_Button6_pressed():
	if i == 1:
		pistegit("06")
	pass

func _on_Button7_pressed():
	if i == 1:
		pistegit("07")
	pass

func _on_Button8_pressed():
	if i == 1:
		pistegit("08")
	pass

func _on_Button9_pressed():
	if i == 1:
		pistegit("09")
	pass

func _on_Button0_pressed():
	if i == 1:
		pistegit("00")
	pass

func _on_Button10_pressed():
	if i == 1:
		pistegit("10")
	pass
