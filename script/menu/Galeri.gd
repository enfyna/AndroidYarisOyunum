extends Control

func uyari(para = 0):
	$"uyarı/Label".text = tr("u1") % [para - Global.Save.get_save()["para"]["para"]]
	$"uyarı".window_title = tr("parayok")
	$"uyarı".popup()

func _on_Button_pressed():
	$"uyarı".hide()
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass

var arababilgileri = {
	"AE86":tr("ae86bilgi"), 
	"STEC":tr("stecbilgi"),
}

var secilenaraba

func bilgi(araba):
	$bilgi.title = araba
	$"bilgi/BilgiText".text = arababilgileri[araba]
	$bilgi.get_ok_button().text = tr("satinal")
	$bilgi.get_cancel_button().text = tr("vazgec")
	$"bilgi".popup()

func _on_bilgi_confirmed():
	if Global.Save.get_save()["para"]["para"] >= secilenaraba[0]:
		Global.Save.get_save()["arabalar"][secilenaraba[1]]["sahiplik"] = true
		Global.Save.get_save()["oyuncu"]["seciliaraba"] = "res://tscndosyalari/araba/" + str(secilenaraba[2]) + ".tscn"
		Global.Save.get_save()["para"]["para"] -= secilenaraba[0]
		var arabanode = str("HScrollBar/HBoxContainer/Araba" + str(secilenaraba[3]))
		get_node(arabanode).visible = 0
		#$ParaTablo.paralabelguncelle()
		Global.oyunkaydet()
		if Global.Save.get_save()["tutorial"]["giris"] == 4:
			Global.Save.get_save()["tutorial"]["giris"] = 5
			var t = load("res://tscndosyalari/tutorial/Tutorial.tscn").instantiate()
			get_parent().call_deferred("add_child", t)
		pass
	else :
		uyari(secilenaraba[0])
		pass

func _ready():
	if Global.Save.get_save()["tutorial"]["giris"] == 2:
		Global.Save.get_save()["para"]["para"] += 10000
		#$ParaTablo.paralabelguncelle()
		var t = load("res://tscndosyalari/tutorial/Tutorial.tscn").instantiate()
		get_parent().call_deferred("add_child", t)
		Global.Save.get_save()["tutorial"]["giris"] = 3
	var arabanode
	for i in range(len(Global.Save.get_save()["arabalar"])):
		arabanode = str("HScrollBar/HBoxContainer/Araba" + str(i))
		
		arabanode = get_node(arabanode)
		if Global.Save.get_save()["arabalar"][arabanode.get_child(0).name]["sahiplik"] == false:
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

