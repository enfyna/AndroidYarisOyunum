extends Control
var t
var kontrol = 0

func sahnedegistir(k):
	if k == 1:
		Global.oyunkaydet()
		Global.oynat("res://muzik/uisounds/clicksound.ogg")
		get_parent().call_deferred("add_sibling",get_parent().get_node("/root/Global"),t)
		get_tree().call_deferred("set_current_scene",t)
		call_deferred("free")

func _on_Zkbutonu_pressed():
	t = load("res://tscndosyalari/menu/PistSecim.tscn").instantiate()
	t.mod = "Zaman"
	kontrol += 1
	sahnedegistir(kontrol)
	pass 
func _on_yarisbutonu_pressed():
	t = load("res://tscndosyalari/menu/PistSecim.tscn").instantiate()
	t.mod = "Yaris"
	kontrol += 1
	sahnedegistir(kontrol)
	pass
func _on_Ayarlarbutonu_pressed():
	t = load("res://tscndosyalari/menu/Ayarlar.tscn").instantiate()
	kontrol += 1
	sahnedegistir(kontrol)
	pass 
func _on_Galeributonu_pressed():
	t = load("res://tscndosyalari/menu/Galeri.tscn").instantiate()
	kontrol += 1
	sahnedegistir(kontrol)
	pass
func _on_Pistlerbutonu_pressed():
	t = load("res://tscndosyalari/menu/Dunya.tscn").instantiate()
	kontrol += 1
	sahnedegistir(kontrol)
	pass
func _on_Garajbutonu_pressed():
	t = load("res://tscndosyalari/menu/Garaj.tscn").instantiate()
	kontrol += 1
	sahnedegistir(kontrol)
	pass
func _on_Marketbutonu_pressed():
	t = load("res://tscndosyalari/menu/Marketv2.tscn").instantiate()
	kontrol += 1
	sahnedegistir(kontrol)
	pass
func _on_PistSatinAl_pressed():
	t = load("res://tscndosyalari/menu/Pist.tscn").instantiate()
	kontrol += 1
	sahnedegistir(kontrol)
	pass
func _on_Oyuncubutonu_pressed():
	t = load("res://tscndosyalari/menu/Oyuncu.tscn").instantiate()
	kontrol += 1
	sahnedegistir(kontrol)
	pass
func _on_Basarimlarbutonu_pressed():
	t = load("res://tscndosyalari/menu/Basarimlar.tscn").instantiate()
	kontrol += 1
	sahnedegistir(kontrol)
	pass 
###########
func _on_TestPist_pressed():
	if Global.kayit["oyuncu"]["seciliaraba"] != "":
		Global.oynat("res://muzik/uisounds/clicksound.ogg")
		var secilenpist = "res://tscndosyalari/pist/PistTest01.tscn"
		t = load(str("res://tscndosyalari/menu/YarisYukle.tscn")).instantiate()
		t.secilenpist = secilenpist
		t.mod = "Zaman"
		t.test = true
		t.yaristur = 0
		get_parent().call_deferred("add_sibling",get_parent().get_node("/root/Global"),t)
		get_tree().call_deferred("set_current_scene",t)
		call_deferred("free")
	else:
		Global.oynat("res://muzik/uisounds/confirm.ogg")
		$uyari.window_title = tr("arabayok")
		$uyari.get_ok_button().text = tr("tamam")
		$uyari.popup_centered()
		pass
	pass
func _on_Button_pressed():
	Global.oyunkaydet()
	Global.oynat("res://muzik/uisounds/clicksound.ogg")
	var silinecek = get_tree().get_current_scene()
	t = load("res://tscndosyalari/menu/AnaMenu.tscn").instantiate()
	get_tree().root.call_deferred("add_sibling",get_parent().get_node("/root/Global"),t)
	get_tree().call_deferred("set_current_scene",t)
	silinecek.call_deferred("free")
	pass
