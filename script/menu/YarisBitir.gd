extends Button
@onready var paralabel = $h / v2 / ParaOdulu
@onready var bronzlabel = $h / v2 / BronzOdulu
@onready var gumuslabel = $h / v2 / GumusOdulu
@onready var altinlabel = $h / v2 / AltinOdulu
@onready var bonuslabel = $h / v2 / BonusOdulu
var paradurum = 0
var kazanmabonusu
var bonusidx = 0
var durum = ""
var sure
var altin
var altinidx = 0
var gumus
var gumusidx = 0
var bronz
var bronzidx = 0
var para
var paraidx = 0
var adim = 1
var tur
var mod
func _ready():
	set_process(false)
	$reklam.visible = false
	$Reklamlabel.visible = false
	$devamet.text = tr("devamet")
	$devamet.visible = false
	paradurum = sign(para)
	if paradurum < 0:
		paralabel.add_theme_color_override("font_color", Color(1, 0, 0, 1))
	else :
		paralabel.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	var stylbx =  get_theme_stylebox("hover").duplicate()
	if durum == "Kazandın!":
		stylbx.bg_color = Color(0, 0.5, 0, 1)
		add_theme_stylebox_override("hover", stylbx)
		add_theme_stylebox_override("normal", stylbx)
		add_theme_stylebox_override("pressed", stylbx)
		$Baslik.text = tr("kazandin")
	elif durum == "Kaybettin.":
		stylbx.bg_color = Color(0.5, 0, 0, 1)
		add_theme_stylebox_override("hover", stylbx)
		add_theme_stylebox_override("normal", stylbx)
		add_theme_stylebox_override("pressed", stylbx)
		$Baslik.text = tr("kaybettin")
	elif durum == "Zamana Karşı!":
		stylbx.bg_color = Color(0, 0.5, 0.5, 1)
		add_theme_stylebox_override("hover", stylbx)
		add_theme_stylebox_override("normal", stylbx)
		add_theme_stylebox_override("pressed", stylbx)
		$Baslik.text = tr("zamanakarsi")
	if tur == - 1:
		tur = 0
	$Tur.text = str(tur) + " " + tr("tur")
	paralabel.text = "0"
	bronzlabel.text = "0"
	gumuslabel.text = "0"
	altinlabel.text = "0"
	$h / v / Kazanmabonusu.visible = false
	$h / v2 / BonusOdulu.visible = false
	if mod == "Yaris":
		bronzlabel.visible = false
		gumuslabel.visible = false
		altinlabel.visible = false
		$h / v / BronzOdulu.visible = false
		$h / v / GumusOdulu.visible = false
		$h / v / AltinOdulu.visible = false
		$h / v / Kazanmabonusu.visible = true
		bonuslabel.visible = true
		bonuslabel.text = "0"
	if altin == 0:
		altinlabel.visible = false
		$h / v / AltinOdulu.visible = false
	else :
		$h / v / AltinOdulu.text = tr("maltin") + str(":")
	if gumus == 0:
		gumuslabel.visible = false
		$h / v / GumusOdulu.visible = false
	else :
		$h / v / GumusOdulu.text = tr("mgumus") + str(":")
	if bronz == 0:
		bronzlabel.visible = false
		$h / v / BronzOdulu.visible = false
	else :
		$h / v / BronzOdulu.text = tr("mbronz") + str(":")
	if para == 0:
		paralabel.visible = false
		$h / v / ParaOdulu.visible = false
	else :
		$h / v / ParaOdulu.text = tr("mpara") + str(":")
	if kazanmabonusu == 0:
		bonuslabel.visible = false
		$h / v / Kazanmabonusu.visible = false
	else :
		$h / v / Kazanmabonusu.text = tr("bonus") + str(":")
		pass

	$ToplamSure.text = str(int(sure / 60000)) + ":" + str(int(sure % 60000) / 1000).pad_zeros(2) + "." + str(sure % 1000).pad_zeros(3)
	AudioManager.ackapat()
	$Reklamlabel.text = tr("reklamoner") % [abs(kazanmabonusu) + abs(para)] + str(":")
	$reklam.text = tr("izle")
	
	tween.interpolate_property(get_node("."), "position", Vector2(0, 720), Vector2(0, 0)
	, 1, Tween.TRANS_QUINT, Tween.EASE_IN)
	tween.start()
	pass
	
func _process(_delta):
	if abs(para) > abs(paraidx):
		paraidx += int(paradurum) * 5
		paralabel.text = str("+") + str(paraidx) if paradurum > 0 else str(paraidx)
	else :
		paralabel.text = str("+") + str(para) if paradurum > 0 else str(para)
	if abs(bronz) > abs(bronzidx):
		bronzidx += 1
		bronzlabel.text = str("+") + str(bronzidx)
	else :
		pass
	if abs(gumus) > abs(gumusidx):
		gumusidx += 1
		gumuslabel.text = str("+") + str(gumusidx)
	else :
		pass
	if abs(altin) > abs(altinidx):
		altinidx += 1
		altinlabel.text = str("+") + str(altinidx)
	else :
		pass
	if abs(kazanmabonusu) > abs(bonusidx):
		bonusidx += 10
		bonuslabel.text = str("+") + str(bonusidx)
	else :
		pass
	pass
func _on_devamet_pressed():
	anamenuyedon()
@onready var tween = $Tween
var t
func anamenuyedon():
	Global.oyunkaydet()
	t = load("res://tscndosyalari/menu/AnaMenu.tscn").instantiate()
	get_tree().root.call_deferred("add_sibling", get_parent().get_node("/root/Arkaplanmuzik"), t)
	get_tree().call_deferred("set_current_scene", t)
	tween.interpolate_property(get_node("."), "position", Vector2(0, 0), Vector2(0, 720)
	, 1, Tween.TRANS_QUINT, Tween.EASE_IN)
	tween.start()
func _on_Tween_tween_completed(_object, _key):
	if adim == 1:
		var silinecek = get_tree().get_current_scene()
		silinecek.call_deferred("free")
		get_tree().set_current_scene(self)
		$devamet.visible = true
		if abs(kazanmabonusu) > 0 or abs(para) > 0:
			$reklam.visible = true
			$Reklamlabel.visible = true
		adim = 2
		set_process(true)
	elif adim == 2:
		call_deferred("free")


@onready var admob = $AdMob
func _on_reklam_pressed():
	$devamet.visible = false
	$reklam.text = tr("yukleniyor")
	admob.rewarded_id = "ca-app-pub-9739592964869796/9609268572"
	admob.load_rewarded_video()
func _on_AdMob_rewarded_video_failed_to_load(_error_code):
	$reklam.text = tr("rhata")
	anamenuyedon()
func _on_AdMob_rewarded(_currency, _amount):
	Global.kayit["para"]["para"] = abs(kazanmabonusu) + abs(para)
func _on_AdMob_rewarded_video_loaded():
	admob.show_rewarded_video()
func _on_AdMob_rewarded_video_closed():
	anamenuyedon()


"func _on_YarisBitir_pressed():\n	adim += 1\n	if adim == 1:\n		pass\n	if adim == 2:\n		anamenuyedon()\n		pass\n	pass "

	
"var silinecek = get_tree().get_current_scene()\nsilinecek.call_deferred(\"free\")\nget_tree().set_current_scene(self)\n$devamet.visible = true\nif kazanmabonusu > 0 or para > 0:\n	$reklam.visible = true\n	$Reklamlabel.visible = true\nset_process(false)"

