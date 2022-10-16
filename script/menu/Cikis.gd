extends ConfirmationDialog
func _ready():
	window_title = tr("ayril")
	get_cancel().text = tr("hayir")
	get_ok().text = tr("tamam")
	var _err = get_cancel().connect("pressed", self, "cancelled")
	popup()
func _on_Cikis_confirmed():
	var tween = create_tween()
	tween.connect("finished",self,"quit")
	tween.tween_property(get_tree().get_current_scene(),"modulate",Color(0,0,0,1),0.5)
func quit():
	get_tree().quit()

func _on_Cikis_modal_closed():
	call_deferred("free")
func cancelled():
	call_deferred("free")
