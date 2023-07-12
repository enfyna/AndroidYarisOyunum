extends TextureProgressBar
var anlikxp = Global.kayit["oyuncu"]["xp"]
@onready var label = $Label
@onready var tween = $Tween
func _ready():
	label.text = str(Global.kayit["oyuncu"]["lvl"])
	value = anlikxp
	renk()
func xparttir():
	if not label.text == str(Global.kayit["oyuncu"]["lvl"]):
		label.text = str(Global.kayit["oyuncu"]["lvl"])
		$levelup.play()
		renk()
	tween.interpolate_property(get_node("."), "anlikxp", 
	anlikxp, Global.kayit["oyuncu"]["xp"]
	, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pass
func _on_Tween_tween_step(_object, _key, _elapsed, _value):
	value = anlikxp
	pass
func _on_Tween_tween_completed(_object, _key):
	anlikxp = Global.kayit["oyuncu"]["xp"]
	pass
func renk():
	if int(Global.kayit["oyuncu"]["lvl"]) < 10:
		tint_progress = Color(1, 1, 1, 1)
		$Label.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	elif int(Global.kayit["oyuncu"]["lvl"]) < 25:
		tint_progress = Color(0.6, 0.2, 0, 1)
		$Label.add_theme_color_override("font_color", Color(0.6, 0.2, 0, 1))
	elif int(Global.kayit["oyuncu"]["lvl"]) < 50:
		tint_progress = Color(0.6, 0.6, 0.6, 1)
		$Label.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6, 1))
	elif int(Global.kayit["oyuncu"]["lvl"]) < 100:
		tint_progress = Color(1, 1, 0, 1)
		$Label.add_theme_color_override("font_color", Color(1, 1, 0, 1))
	elif int(Global.kayit["oyuncu"]["lvl"]) < 500:
		tint_progress = Color(0, 1, 1, 1)
		$Label.add_theme_color_override("font_color", Color(0, 1, 1, 1))
	else :
		tint_progress = Color(0.6, 0, 1, 1)
		$Label.add_theme_color_override("font_color", Color(0.6, 0, 1, 1))
