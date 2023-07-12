extends Control

func _ready():
	
	var arabastr
	arabastr =str(Global.kayit["oyuncu"]["seciliaraba"])
	arabastr.erase(0,26)
	arabastr.erase(arabastr.length() - 5 ,5)
	$ScrollContainer/VBoxContainer/araba.text = "\n Şu an kullandığın araba : " + arabastr + "\n"
	
	var motor 
	var yag
	if Global.kayit["tekerlekler"]["motor"] > 90:
		motor = 1.0
	elif Global.kayit["tekerlekler"]["motor"] > 70:
		motor = 0.9
	elif Global.kayit["tekerlekler"]["motor"] > 50:
		motor = 0.8
	elif Global.kayit["tekerlekler"]["motor"] > 20:
		motor = 0.5
	elif Global.kayit["tekerlekler"]["motor"] > 0:
		motor = 0.2
	else:
		motor = 0.0
	if Global.kayit["tekerlekler"]["yag"] > 30:
		yag = 1.0
	elif Global.kayit["tekerlekler"]["yag"] > 0:
		yag = 0.8
	else:
		yag = 0.5
		
	$ScrollContainer/VBoxContainer/motor.text = "\n Motorunun durumu %" + str(float(motor * yag * 100)) + "\n"
	if motor * yag * 100 < 70 :
		$ScrollContainer/VBoxContainer/motor.add_theme_color_override("font_color",Color(1,0,0,1))
	
	"""" 
	if true:
		if Global.xp[0] < 25 and Global.xp[0] >= 10:
			$Label/Label/VBoxContainer/Control/level.tint_over = Color(0.6,0.2,0,1)
			$Label/Label/VBoxContainer/Control/rank.text = "Bronz"
			$Label/Label/VBoxContainer/Control/rank.add_theme_color_override("font_color",Color(0.6,0.2,0,1))
			$Label/Label/VBoxContainer/Control/rank.add_theme_color_override("font_color_shadow",Color(0,0,0,1))
			$Label/Label/VBoxContainer/Control/levelpng.texture = load("res://resimler/menu/paratablo/bronz2.png")
		elif Global.xp[0] >= 100 :
			$Label/Label/VBoxContainer/Control/level.tint_over = Color(0,1,1,1)
			$Label/Label/VBoxContainer/Control/rank.text = "Elmas"
			$Label/Label/VBoxContainer/Control/rank.add_theme_color_override("font_color",Color(0,1,1,1))
			$Label/Label/VBoxContainer/Control/rank.add_theme_color_override("font_color_shadow",Color(1,1,1,1))
			$Label/Label/VBoxContainer/Control/levelpng.texture = load("res://resimler/menu/paratablo/elmas2.png")
		elif Global.xp[0] >= 50 :
			$Label/Label/VBoxContainer/Control/rank.text = "Altın"
			$Label/Label/VBoxContainer/Control/rank.add_theme_color_override("font_color",Color(1,1,0,1))
			$Label/Label/VBoxContainer/Control/rank.add_theme_color_override("font_color_shadow",Color(1,1,1,1))
			$Label/Label/VBoxContainer/Control/level.tint_over = Color(1,1,0,1)
			$Label/Label/VBoxContainer/Control/levelpng.texture = load("res://resimler/menu/paratablo/altin2.png")
		elif Global.xp[0] >= 25 :
			$Label/Label/VBoxContainer/Control/rank.text = "Gümüş"
			$Label/Label/VBoxContainer/Control/rank.add_theme_color_override("font_color",Color(0.6,0.6,0.6,1))
			$Label/Label/VBoxContainer/Control/rank.add_theme_color_override("font_color_shadow",Color(0,0,0,1))
			$Label/Label/VBoxContainer/Control/level.tint_over = Color(0.6,0.6,0.6,1)
			$Label/Label/VBoxContainer/Control/levelpng.texture = load("res://resimler/menu/paratablo/gumus2.png")
		else:
			$Label/Label/VBoxContainer/Control.visible = false
	"""
#var ms
#var saniye
#var dakika
var saat
var gecenzaman
var z

func _process(_delta):
	z = Global.kayit["tarih"]["toplamoynamasure"]
	#ms =  int(z%1000)
	#saniye = int((z/1000)%60)
	#dakika = int((z/60000)%60)
	saat = int(z/3600000)
	gecenzaman = "%d"%[saat]#:%02d:%02d" %[saat]
	$ScrollContainer/VBoxContainer/sure.text = "\nOyunu " + gecenzaman + " saat oynadın.\n"
	
	pass
