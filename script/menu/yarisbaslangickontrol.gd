extends TextureRect

var kazanmabonusu
var r
var mod
var test = false
var secilenpist = "res://tscndosyalari/pist/PistTest01.tscn"
var araba = Global.Save.get_save()["oyuncu"]["seciliaraba"]
var yaristur
var bot
var loader
var queue 
var adim = 1
var infotext = [
	tr("yb1"),
	tr("yb2"),
	tr("yb3"),
	tr("yb4"),
	tr("yb5"),
	tr("yb6"),
	tr("yb7"),
	tr("yb8"),
]
var yazi = {
	"mod":tr("loadm"),
	"pist":tr("loadp"),
	"araba":tr("loada"),
	"bot":tr("loadb"),
	"tamam":tr("yuklemetamam")
}

const yaris_tscn = "res://tscndosyalari/menu/Yaris.tscn"
const bot_tscn = "res://tscndosyalari/bot/bot.tscn"

func _ready():
	visible = true
	randomize()
	r = randi() % infotext.size()
	$info.text = infotext[r]
	queue = [araba,yaris_tscn,secilenpist]
	if mod == "Yaris":
		queue.append(bot_tscn)
	for i in queue:
		ResourceLoader.load_threaded_request(i)

func _process(_delta):
	Input.action_press("ui_down")
	for i in queue:
		var status : Array = []
		ResourceLoader.load_threaded_get_status(i,status)
		if status[0] == 1:
			queue.erase(i)
			if len(queue) == 0:
				var yaris_node : Node = ResourceLoader.load_threaded_get(yaris_tscn).instantiate()
				get_parent().add_child(yaris_node)
				yaris_node.mod = mod
				yaris_node.test = test
				if test == true:
					yaris_node.get_node("CizgiModeli").queue_free()
				yaris_node.yaristur = yaristur
				yaris_node.kazanmabonusu = kazanmabonusu

				var pist_node : Node = ResourceLoader.load_threaded_get(secilenpist).instantiate()
				yaris_node.add_child(pist)
				yaris_node.yarispist = pist_node
				yaris_node.pistindexayarla()

				var araba_node = ResourceLoader.load_threaded_get(araba).instantiate()
				yaris_node.add_child(araba_node)
				yaris_node.player = araba_node
				araba_node.position.z = - 15
				araba_node.position.x = - 3
				
				if mod == "Yaris":
					var bot_node : Node = ResourceLoader.load_threaded_get(bot_tscn).instantiate()
					yaris_node.add_child(bot_node)
					bot_node.position.z = - 5
					bot_node.position.x = 3
					bot_node.kirmizi = true
					bot_node.player = araba
					yaris_node.bot = bot_node
				yuklemetext.text = tr("yuklemetamam")
				set_process(false)
				tamamlandi()
	""" if adim == 1:
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
		yuklemetext.text = yazi["bot"] + str(deger) + "%" """

func yukle(loader):
	if loader == null:
		return
	var err = loader.load_threaded_get_status()
	if err == ERR_FILE_EOF:
		var resource = loader.get_resource()
		if adim == 1:
			yaris = resource.instantiate()
			yaris.mod = mod
			yaris.test = test
			if test == true:
				yaris.get_node("CizgiModeli").queue_free()
			yaris.yaristur = yaristur
			yaris.kazanmabonusu = kazanmabonusu
			get_parent().add_sibling(get_parent().get_node("/root/Arkaplanmuzik"), yaris)
			get_tree().set_current_scene(yaris)
			adim = 2
		elif adim == 2:
			pist = resource.instantiate()
			yaris.yarispist = pist
			yaris.pistindexayarla()
			get_parent().get_node("/root/Yaris").add_child(pist)
			adim = 3
		elif adim == 3:
			araba = resource.instantiate()
			araba.position.z = - 15
			araba.position.x = - 3
			yaris.player = araba
			get_parent().get_node("/root/Yaris").add_child(araba)
			adim = 4
			if mod == "Zaman":
				adim = 5
				yuklemetext.text = tr("yuklemetamam")
				set_process(false)
				tamamlandi()
		elif adim == 4:
			bot = resource.instantiate()
			bot.position.z = - 5
			bot.position.x = 3
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

@onready var bar = $yuklemebar
var deger = 0
func yuklemebar(loader):
	bar.value = float(loader.get_stage()) / loader.get_stage_count()
	deger = int(bar.value * 100)
	pass


@onready var yuklemetext = $yuklemebar / text

func tamamlandi():
	yuklemetext.text = tr("yuklemetamam")
	bar.value = 1
	var tween : Tween = create_tween()
	tween.tween_property(
		self, "position", Vector2(0, 720), 1
	).set_trans(Tween.TRANS_QUINT)
	tween.tween_callback(_on_Tween_tween_completed)

func _on_Tween_tween_completed():
	yaris.kirmiziisik()
	call_deferred("free")
	pass

var yaris
var pist
