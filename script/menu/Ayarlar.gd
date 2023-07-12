extends Control
var ayarlarnode
func _ready():
	$Label / hassasiyet.value = Global.Save.get_save()["ayarlar"]["hassasiyet"]
	$Label.text = tr("hassasiyet")
	for i in range(len(Global.Save.get_save()["ayarlar"]) - 1):
		ayarlarnode = str("Label" + str(i))
		
		ayarlarnode = get_node(ayarlarnode)
		ayarlarnode.text = tr("a" + str(i))
		if Global.Save.get_save()["ayarlar"][ayarlarnode.get_child(0).name]:
			ayarlarnode.get_child(0).button_pressed = true
		else :
			ayarlarnode.get_child(0).button_pressed = false

func _on_hassasiyet_drag_ended(_value_changed):
	Global.Save.get_save()["ayarlar"]["hassasiyet"] = $Label / hassasiyet.value
	$Label / hassasiyet.value = Global.Save.get_save()["ayarlar"]["hassasiyet"]
func _on_oto_toggled(button_pressed):
	Global.Save.get_save()["ayarlar"]["oto"] = button_pressed
func _on_sis_toggled(button_pressed):
	Global.Save.get_save()["ayarlar"]["sis"] = button_pressed
func _on_input_toggled(button_pressed):
	Global.Save.get_save()["ayarlar"]["input"] = button_pressed
func _on_muzik_toggled(button_pressed):
	Global.Save.get_save()["ayarlar"]["muzik"] = button_pressed
	Arkaplanmuzik.ackapat(button_pressed)
func _on_koyu_toggled(button_pressed):
	Global.Save.get_save()["ayarlar"]["koyu"] = button_pressed
	$arkaplan.koyu(button_pressed)
func _on_kmh_toggled(button_pressed):
	Global.Save.get_save()["ayarlar"]["kmh"] = button_pressed
