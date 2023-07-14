extends Control
var pistsayisi = 11
var paratablo
func _ready():
	var pistnode
	var butonnode
	for i in range(pistsayisi):
		var idx = Global.kayit["pistler"].keys()[i]
		pistnode = str("HScrollBar/HBoxContainer/" + str(idx))
		butonnode = str(pistnode + "/sutun/Container2/Button")
		if Global.kayit["pistler"][idx] == 0:
			get_node(pistnode).visible = 1
			get_node(butonnode).text = tr("satinal")
		else :
			get_node(pistnode).queue_free()
	paratablo = load("res://tscndosyalari/menu/ParaTablo.tscn").instantiate()
	add_child(paratablo)
	pass
var pistbilgileri = {"Pist 1":tr("fiyat") + ":10.000", 
						"Pist 2":tr("fiyat") + ":20.000"}
var secilenpist
func bilgi(pist):
	$bilgi.window_title = tr("pist") + " " + pist
	$"bilgi/BilgiText".text = pistbilgileri[secilenpist[2]]
	$bilgi.get_ok_button().text = tr("satinal")
	$bilgi.get_cancel_button().text = tr("vazgec")
	$"bilgi".popup()
func _on_bilgi_confirmed():
	if Global.kayit["para"]["para"] >= secilenpist[0]:
		Global.kayit["pistler"][str(secilenpist[1])] = 1
		Global.kayit["para"]["para"] -= secilenpist[0]
		paratablo.paralabelguncelle()
		var node = str("HScrollBar/HBoxContainer/" + str(secilenpist[1]))
		get_node(node).visible = 0
		Global.oyunkaydet()
	else :
		uyari(secilenpist[0])

func uyari(para = 0):
	$"uyarı/Label".text = "%d Paraya daha ihtiyacın var." % [para - Global.kayit["para"]["para"]]
	$"uyarı".popup()
func _on_Button_pressed():
	$"uyarı".hide()
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")

func _on_Button1_pressed():
	secilenpist = [10000, "Pist01", "Pist 1"]
	bilgi("1")
func _on_Button2_pressed():
	secilenpist = [10000, "Pist02", "Pist 1"]
	bilgi("2")
func _on_Button3_pressed():
	secilenpist = [10000, "Pist03", "Pist 1"]
	bilgi("3")
func _on_Button4_pressed():
	secilenpist = [10000, "Pist04", "Pist 1"]
	bilgi("4")
func _on_Button5_pressed():
	secilenpist = [10000, "Pist05", "Pist 1"]
	bilgi("5")
func _on_Button6_pressed():
	secilenpist = [10000, "Pist06", "Pist 1"]
	bilgi("6")
func _on_Button7_pressed():
	secilenpist = [10000, "Pist07", "Pist 1"]
	bilgi("7")
func _on_Button8_pressed():
	secilenpist = [10000, "Pist08", "Pist 1"]
	bilgi("8")
func _on_Button9_pressed():
	secilenpist = [10000, "Pist09", "Pist 1"]
	bilgi("9")
func _on_Button0_pressed():
	secilenpist = [10000, "Pist00", "Pist 1"]
	bilgi("10")
func _on_Button10_pressed():
	secilenpist = [20000, "Pist10", "Pist 2"]
	bilgi("11")












"\"\n	if true:\n		if Global.sahipolunanpistler[0] == 0:\n			$HScrollBar/HBoxContainer/pist1.visible = 1\n		else:\n			$HScrollBar/HBoxContainer/pist1.visible = 0\n		\n		if Global.sahipolunanpistler[1] == 0:\n			$HScrollBar/HBoxContainer/pist2.visible = 1\n		else:\n			$HScrollBar/HBoxContainer/pist2.visible = 0\n		\n		if Global.sahipolunanpistler[2] == 0:\n			$HScrollBar/HBoxContainer/pist3.visible = 1\n		else:\n			$HScrollBar/HBoxContainer/pist3.visible = 0\n		\n		if Global.sahipolunanpistler[3] == 0:\n			$HScrollBar/HBoxContainer/pist4.visible = 1\n		else:\n			$HScrollBar/HBoxContainer/pist4.visible = 0\n		\n		if Global.sahipolunanpistler[4] == 0:\n			$HScrollBar/HBoxContainer/pist5.visible = 1\n		else:\n			$HScrollBar/HBoxContainer/pist5.visible = 0\n			\n		if Global.sahipolunanpistler[5] == 0:\n			$HScrollBar/HBoxContainer/pist6.visible = 1\n		else:\n			$HScrollBar/HBoxContainer/pist6.visible = 0\n		\n		if Global.sahipolunanpistler[6] == 0:\n			$HScrollBar/HBoxContainer/pist7.visible = 1\n		else:\n			$HScrollBar/HBoxContainer/pist7.visible = 0\n		\n		if Global.sahipolunanpistler[7] == 0:\n			$HScrollBar/HBoxContainer/pist8.visible = 1\n		else:\n			$HScrollBar/HBoxContainer/pist8.visible = 0\n		\n		if Global.sahipolunanpistler[8] == 0:\n			$HScrollBar/HBoxContainer/pist9.visible = 1\n		else:\n			$HScrollBar/HBoxContainer/pist9.visible = 0\n		\n		if Global.sahipolunanpistler[9] == 0:\n			$HScrollBar/HBoxContainer/pist0.visible = 1\n		else:\n			$HScrollBar/HBoxContainer/pist0.visible = 0\n		\n		if Global.sahipolunanpistler[10] == 0:\n			$HScrollBar/HBoxContainer/pist10.visible = 1\n		else:\n			$HScrollBar/HBoxContainer/pist10.visible = 0\n	"
