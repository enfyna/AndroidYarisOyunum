extends Control
func _ready():
	ppayarla()
func ppayarla():
	var node
	for i in range(len(Global.kayit["arabalar"])):
		node = str("HScrollBar/HBoxContainer")
		node = get_node(node)
		node.get_child(i).visible = Global.kayit["arabalar"][node.get_child(i).name]["sahiplik"]
		if node.get_child(i).visible:
			var isim = Global.kayit["oyuncu"]["seciliaraba"]
			isim.erase(0,26)
			isim.erase(isim.length()-5,5)
			isim = isim.to_lower()
			if node.get_child(i).name != isim:
				node.get_child(i).modulate = Color(0.5,0.5,0.5,1)
			else:
				node.get_child(i).modulate = Color(1,1,1,1)
	pass
func _on_Button1_pressed():
	Global.kayit["oyuncu"]["seciliaraba"] = "res://tscndosyalari/araba/AE86.tscn"
	ppayarla()
	Global.oynat("buton")
func _on_Button2_pressed():
	Global.kayit["oyuncu"]["seciliaraba"] = "res://tscndosyalari/araba/Tico.tscn"
	ppayarla()
	Global.oynat("buton")
