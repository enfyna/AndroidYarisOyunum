extends ConfirmationDialog
func _ready():
	window_title = tr("ayril")
	get_cancel_button().text = tr("hayir")
	get_ok_button().text = tr("tamam")
	var _err = get_cancel_button().connect("pressed", Callable(self, "canceled"))
	popup()
func _on_Cikis_confirmed():
	var tween = create_tween()
	tween.connect("finished", Callable(self, "quit"))
	tween.tween_property(get_tree().get_current_scene(),"modulate",Color(0,0,0,1),0.5)
func quit():
	get_tree().quit()

func _on_Cikis_modal_closed():
	call_deferred("free")
func canceled():
	call_deferred("free")
