extends ConfirmationDialog
func _ready():
	window_title = tr("ayril")
	get_cancel().text = tr("hayir")
	get_ok().text = tr("tamam")

	get_cancel().connect("pressed", self, "cancelled")
	popup()
func _on_Cikis_confirmed():
	var alfa = 1
	while alfa > 0:
		get_tree().get_current_scene().modulate = Color(alfa, alfa, alfa, 1)
		yield (get_tree().create_timer(0.02), "timeout")
		alfa -= 0.1
	get_tree().quit()

func _on_Cikis_modal_closed():
	call_deferred("free")
func cancelled():
	call_deferred("free")
