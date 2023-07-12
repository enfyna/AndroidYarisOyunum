extends TextureRect

func _ready():
	if not Global.kayit["ayarlar"]["koyu"]:
		texture = load("res://resimler/arkaplan/anamenuarka7.png")
	else:
		texture = load("res://resimler/arkaplan/anamenuarka7dark.png")
	
	var araba : String = str(Global.kayit["oyuncu"]["seciliaraba"])
	araba.erase(0, 26)
	araba.erase(araba.length() - 5, 5)
	araba = araba.to_lower()
	if araba != "":
		var seciliaraba = str("res://resimler/menu/garaj/" + araba + "t.png")
		get_parent().get_node("hb/araba").texture = load(seciliaraba)
	else :
		get_parent().get_node("hb/araba").texture = load("res://resimler/menu/garaj/bos.png")
	
	if Global.kayit["tutorial"]["giris"] == 0 or Global.kayit["tutorial"]["giris"] == 6:
		var t = load("res://tscndosyalari/menu/Tutorial.tscn").instantiate()
		get_parent().call_deferred("add_child", t)
	if Global.kayit["tutorial"]["giris"] == 6:
		Global.kayit["tutorial"]["giris"] = 7