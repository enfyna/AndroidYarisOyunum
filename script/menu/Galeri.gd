extends Control
func uyari(para = 0):
	$"uyarı/Label".text = tr("u1") % [para - Global.kayit["para"]["para"]]
	$"uyarı".window_title = tr("parayok")
	$"uyarı".popup()
func _on_Button_pressed():
	$"uyarı".hide()
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass
var arababilgileri = {"AE86":tr("ae86bilgi"), 
							"STEC":tr("stecbilgi")}
var secilenaraba
func bilgi(araba):
	$bilgi.window_title = araba
	$"bilgi/BilgiText".text = arababilgileri[araba]
	$bilgi.get_ok().text = tr("satinal")
	$bilgi.get_cancel().text = tr("vazgec")
	$"bilgi".popup()
func _on_bilgi_confirmed():
	if Global.kayit["para"]["para"] >= secilenaraba[0]:
		Global.kayit["arabalar"][secilenaraba[1]]["sahiplik"] = true
		Global.kayit["oyuncu"]["seciliaraba"] = "res://tscndosyalari/araba/" + str(secilenaraba[2]) + ".tscn"
		Global.kayit["para"]["para"] -= secilenaraba[0]
		var arabanode = str("HScrollBar/HBoxContainer/Araba" + str(secilenaraba[3]))
		get_node(arabanode).visible = 0
		$ParaTablo.paralabelguncelle()
		Global.oyunkaydet()
		if Global.kayit["tutorial"]["giris"] == 4:
			Global.kayit["tutorial"]["giris"] = 5
			var t = load("res://tscndosyalari/menu/Tutorial.tscn").instance()
			get_parent().call_deferred("add_child", t)
		pass
	else :
		uyari(secilenaraba[0])
		pass

func _ready():
	if Global.kayit["tutorial"]["giris"] == 2:
		Global.kayit["para"]["para"] += 10000
		$ParaTablo.paralabelguncelle()
		var t = load("res://tscndosyalari/menu/Tutorial.tscn").instance()
		get_parent().call_deferred("add_child", t)
		Global.kayit["tutorial"]["giris"] = 3
	var arabanode
	for i in range(len(Global.kayit["arabalar"])):
		arabanode = str("HScrollBar/HBoxContainer/Araba" + str(i))
		
		arabanode = get_node(arabanode)
		if Global.kayit["arabalar"][arabanode.get_child(0).name]["sahiplik"] == false:
			arabanode.visible = true
		else :
			arabanode.visible = false
	
func _on_Araba0_pressed():
	secilenaraba = [50000, "ae86", "AE86", 1]
	bilgi("AE86")
	pass
func _on_Araba1_pressed():
	secilenaraba = [10000, "tico", "STEC", 0]
	bilgi("STEC")
	pass

