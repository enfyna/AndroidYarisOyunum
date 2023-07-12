extends Control
var ayarlarnode
func _ready():
	$Label/hassasiyet.value = Global.kayit["ayarlar"]["hassasiyet"]
	$Label.text = tr("hassasiyet")
	for i in range(len(Global.kayit["ayarlar"])-1):
		ayarlarnode = str("Label" + str(i))
		ayarlarnode = get_node(ayarlarnode)
		ayarlarnode.text = tr("a"+str(i))
		if Global.kayit["ayarlar"][ayarlarnode.get_child(0).name]:
			ayarlarnode.get_child(0).button_pressed = true
		else:
			ayarlarnode.get_child(0).button_pressed = false

func _on_hassasiyet_drag_ended(_value_changed):
	Global.oynat("res://muzik/uisounds/clicksound.ogg")
	Global.kayit["ayarlar"]["hassasiyet"] = $Label/hassasiyet.value 
	$Label/hassasiyet.value = Global.kayit["ayarlar"]["hassasiyet"]
func _on_oto_toggled(button_pressed):
	Global.oynat("res://muzik/uisounds/clicksound.ogg")
	Global.kayit["ayarlar"]["oto"] = button_pressed
func _on_sis_toggled(button_pressed):
	Global.oynat("res://muzik/uisounds/clicksound.ogg")
	Global.kayit["ayarlar"]["sis"] = button_pressed
func _on_input_toggled(button_pressed):
	Global.oynat("res://muzik/uisounds/clicksound.ogg")
	Global.kayit["ayarlar"]["input"] = button_pressed
func _on_muzik_toggled(button_pressed):
	Global.oynat("res://muzik/uisounds/clicksound.ogg")
	Global.kayit["ayarlar"]["muzik"] = button_pressed
	Global.ackapat(button_pressed)
func _on_koyu_toggled(button_pressed):
	Global.oynat("res://muzik/uisounds/clicksound.ogg")
	Global.kayit["ayarlar"]["koyu"] = button_pressed
	$arkaplan.koyu(button_pressed)
func _on_kmh_toggled(button_pressed):
	Global.oynat("res://muzik/uisounds/clicksound.ogg")
	Global.kayit["ayarlar"]["kmh"] = button_pressed




"""func _process(_delta):
	Global.kayit["ayarlar"]["hassasiyet"] = $Label/hassasiyet.value 
	for i in range(len(Global.kayit["ayarlar"])-1):
		ayarlarnode = str("Label" + str(i))# + "/CheckButton"
		ayarlarnode = get_node(ayarlarnode)
		#print(ayarlarnode)
		if ayarlarnode.get_child(0).button_pressed == true:
			Global.kayit["ayarlar"][ayarlarnode.get_child(0).name] = 1
		else:
			Global.kayit["ayarlar"][ayarlarnode.get_child(0).name] = 0
	pass
"""
