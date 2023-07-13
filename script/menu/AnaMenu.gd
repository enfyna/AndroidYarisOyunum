extends Control

func change_scene_with_variable(scene_path : String, args : Array = []):
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	var scene = load(scene_path).instantiate()
	for arg in args:
		scene.set(arg[0],arg[1])
	get_parent().call_deferred("add_child", scene)
	call_deferred("queue_free")
	pass

# func _on_PistSatinAl_pressed():
# 	t = load("res://tscndosyalari/menu/Pist.tscn").instantiate()
# 	sahnedegistir()

func _ready():
	var grid : Node = get_node("hb/gc")
	const translations : Dictionary = {
		"Zk":"zamanakarsi",
		"Pistler":"pistbuton",
		"Market":"marketbuton",
		"Garaj":"garajbuton",
		"Galeri":"galeributon",
		"Basarimlar":"basarimlar",
		"1v1":"yarisbuton",
		"AyarlarveOyuncu":"",
	}
	for node in grid.get_children():
		node.get_child(0).text = tr(translations[node.name])

	var araba : String = str(Global.Save.get_save()["oyuncu"]["seciliaraba"])
	araba.erase(0, 26)
	araba.erase(max(0,araba.length() - 5), 5)
	araba = araba.to_lower()
	if araba != "":
		var seciliaraba = str("res://resimler/menu/garaj/" + araba + "t.png")
		get_node("hb/araba").texture = load(seciliaraba)
	else :
		get_node("hb/araba").texture = load("res://resimler/menu/garaj/bos.png")
		
	if Global.Save.get_save()["tutorial"]["giris"] == 0 or Global.Save.get_save()["tutorial"]["giris"] == 6:
		var t = load("res://tscndosyalari/tutorial/Tutorial.tscn").instantiate()
		call_deferred("add_child", t)
	if Global.Save.get_save()["tutorial"]["giris"] == 6:
		Global.Save.get_save()["tutorial"]["giris"] = 7
