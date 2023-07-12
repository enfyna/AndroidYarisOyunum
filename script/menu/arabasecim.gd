extends Control
func _ready():
	var node
	
	for i in range(len(Global.kayit["arabalar"])):
		node = str("HScrollBar/HBoxContainer")
		node = get_node(node)
		
		node.get_child(i).visible = true if Global.kayit["arabalar"][node.get_child(i).name]["sahiplik"] == true else false
	pass
func _on_Button1_pressed():
	Global.kayit["oyuncu"]["seciliaraba"] = "res://tscndosyalari/araba/AE86.tscn"
	pass
func _on_Button2_pressed():
	Global.kayit["oyuncu"]["seciliaraba"] = "res://tscndosyalari/araba/STEC.tscn"
	pass
