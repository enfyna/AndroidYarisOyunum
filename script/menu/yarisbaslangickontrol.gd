extends TextureRect
var kazanmabonusu
var r
var mod
var test = false
var secilenpist
var araba = Global.kayit["oyuncu"]["seciliaraba"]
var yaristur
var bot
var pistloader
var arabaloader
var botloader
var yarisloader
var adim = 1
var infotext = [tr("yb1"), 
				tr("yb2"), 
				tr("yb3"), 
				tr("yb4"), 
				tr("yb5"), 
				tr("yb6"), 
				tr("yb7"), 
				tr("yb8"), 
				
				]

func _ready():
	
	visible = true
	randomize()
	r = randi() % infotext.size()
	$info.text = infotext[r]
	arabaloader = ResourceLoader.load_interactive(araba)
	yarisloader = ResourceLoader.load_interactive("res://tscndosyalari/menu/Yaris.tscn")
	pistloader = ResourceLoader.load_interactive(secilenpist)
	if mod == "Yaris":
		botloader = ResourceLoader.load_interactive("res://tscndosyalari/bot/bot.tscn")
	pass

var yazi = {"mod":tr("loadm"), 
			"pist":tr("loadp"), 
			"araba":tr("loada"), 
			"bot":tr("loadb"), 
			"tamam":tr("yuklemetamam")}

onready var tween = $Tween
func _process(_delta):
	Input.action_press("ui_down")
	if adim == 1:
		yukle(yarisloader)
		yuklemetext.text = yazi["mod"] + str(deger) + "%"
	elif adim == 2:
		yukle(pistloader)
		yuklemetext.text = yazi["pist"] + str(deger) + "%"
	elif adim == 3:
		yukle(arabaloader)
		yuklemetext.text = yazi["araba"] + str(deger) + "%"
	elif adim == 4:
		yukle(botloader)
		yuklemetext.text = yazi["bot"] + str(deger) + "%"
onready var yuklemetext = $yuklemebar / text
func tamamlandi():
	yuklemetext.text = tr("yuklemetamam")
	bar.value = 1
	tween.interpolate_property(self, "rect_position", Vector2(0, 0), Vector2(0, 720)
	, 1, Tween.TRANS_QUINT, Tween.EASE_IN)
	tween.start()
	pass
func _on_Tween_tween_completed(_object, _key):
	yaris.kirmiziisik()
	call_deferred("free")
	pass
var yaris
var pist

func yukle(loader):
	if loader == null:
		return 
	var err = loader.poll()
	if err == ERR_FILE_EOF:
		var resource = loader.get_resource()
		if adim == 1:
			yaris = resource.instance()
			yaris.mod = mod
			yaris.test = test
			if test == true:
				yaris.get_node("CizgiModeli").queue_free()
			yaris.yaristur = yaristur
			yaris.kazanmabonusu = kazanmabonusu
			get_parent().add_child_below_node(get_parent().get_node("/root/Arkaplanmuzik"), yaris)
			get_tree().set_current_scene(yaris)
			adim = 2
		elif adim == 2:
			pist = resource.instance()
			yaris.yarispist = pist
			yaris.pistindexayarla()
			get_parent().get_node("/root/Yaris").add_child(pist)
			adim = 3
		elif adim == 3:
			araba = resource.instance()
			araba.translation.z = - 15
			araba.translation.x = - 3
			yaris.player = araba
			get_parent().get_node("/root/Yaris").add_child(araba)
			adim = 4
			if mod == "Zaman":
				adim = 5
				yuklemetext.text = tr("yuklemetamam")
				set_process(false)
				tamamlandi()
		elif adim == 4:
			bot = resource.instance()
			bot.translation.z = - 5
			bot.translation.x = 3
			bot.kirmizi = true
			bot.player = araba
			yaris.bot = bot
			get_parent().get_node("/root/Yaris").add_child(bot)
			adim = 5
			yuklemetext.text = tr("yuklemetamam")
			set_process(false)
			tamamlandi()
	elif err == OK:
		yuklemebar(loader)
		pass
	else :
		print("error during loading")
		loader = null
	pass

onready var bar = $yuklemebar
var deger = 0
func yuklemebar(loader):
	bar.value = float(loader.get_stage()) / loader.get_stage_count()
	deger = int(bar.value * 100)
	pass






