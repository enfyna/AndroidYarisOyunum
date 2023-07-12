extends Control
var t : Node
var kontrol : int = 0

func sahnedegistir():
	kontrol += 1
	if kontrol == 1:
		Global.oyunkaydet()
		get_parent().call_deferred("add_child", t)
		call_deferred("queue_free")

func _on_Zkbutonu_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	t = load("res://tscndosyalari/menu/pistsecim.tscn").instantiate()
	t.mod = "Zaman"
	sahnedegistir()
	pass
func _on_yarisbutonu_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	t = load("res://tscndosyalari/menu/pistsecim.tscn").instantiate()
	t.mod = "Yaris"
	sahnedegistir()
	pass
func _on_Ayarlarbutonu_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	t = load("res://tscndosyalari/menu/Ayarlar.tscn").instantiate()
	sahnedegistir()
	pass
func _on_Galeributonu_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	t = load("res://tscndosyalari/menu/Galeri.tscn").instantiate()
	sahnedegistir()
	pass
func _on_Pistlerbutonu_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	t = load("res://tscndosyalari/menu/Dunya.tscn").instantiate()
	sahnedegistir()
	pass
func _on_Garajbutonu_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	t = load("res://tscndosyalari/menu/Garaj.tscn").instantiate()
	sahnedegistir()
	pass
func _on_Marketbutonu_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	t = load("res://tscndosyalari/menu/Market.tscn").instantiate()
	sahnedegistir()
	pass
func _on_PistSatinAl_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	t = load("res://tscndosyalari/menu/Pist.tscn").instantiate()
	sahnedegistir()
	pass
func _on_Oyuncubutonu_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	t = load("res://tscndosyalari/menu/Oyuncu.tscn").instantiate()
	sahnedegistir()
	pass
func _on_Basarimlarbutonu_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	t = load("res://tscndosyalari/menu/Basarimlar.tscn").instantiate()
	sahnedegistir()
	pass

func _on_TestPist_pressed():
	if Global.kayit["oyuncu"]["seciliaraba"] != "":
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
		var secilenpist = "res://tscndosyalari/pist/PistTest01.tscn"
		t = load(str("res://tscndosyalari/menu/YarisYukle.tscn")).instantiate()
		t.secilenpist = secilenpist
		t.mod = "Zaman"
		t.test = true
		t.yaristur = 0
		get_parent().call_deferred("add_sibling", get_parent().get_node("/root/Arkaplanmuzik"), t)
		get_tree().call_deferred("set_current_scene", t)
		call_deferred("free")

func _on_Button_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	Global.oyunkaydet()

	var silinecek = get_parent().get_parent()
	t = load("res://tscndosyalari/menu/AnaMenu.tscn").instantiate()
	silinecek.get_parent().call_deferred("add_child",t)
	
	silinecek.call_deferred("queue_free")
