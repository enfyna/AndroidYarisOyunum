extends TextureRect

@onready var yuklemetext = $yuklemebar / text

const yaris_tscn = "res://tscndosyalari/menu/Yaris.tscn"
const bot_tscn = "res://tscndosyalari/bot/bot.tscn"

var yaris
var pist
var kazanmabonusu
var mod
var test = false
var secilenpist = "res://tscndosyalari/pist/PistTest01.tscn"
var araba = Global.Save.get_save()["oyuncu"]["seciliaraba"]
var yaristur
var bot
var queue
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

func _ready():
	visible = true
	randomize()
	$info.text = infotext[randi() % infotext.size()]
	queue = [araba,yaris_tscn,secilenpist]
	if mod == "Yaris":
		queue.append(bot_tscn)
	for scene in queue:
		ResourceLoader.load_threaded_request(scene)

func _process(_delta):
	for scene in queue:
		var status : int = ResourceLoader.load_threaded_get_status(scene)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			queue.erase(scene)
			if len(queue) == 0:
				sahneyukle()

func sahneyukle():
	var yaris_node : Node = ResourceLoader.load_threaded_get(yaris_tscn).instantiate()
	get_parent().add_child(yaris_node)
	yaris_node.mod = mod
	yaris_node.test = test
	if test == true:
		yaris_node.get_node("CizgiModeli").queue_free()
	yaris_node.yaristur = yaristur
	yaris_node.kazanmabonusu = kazanmabonusu

	var pist_node : Node = ResourceLoader.load_threaded_get(secilenpist).instantiate()
	yaris_node.call_deferred("add_child",pist_node)
	yaris_node.yarispist = pist_node
	yaris_node.pistindexayarla()

	var araba_node : Node = ResourceLoader.load_threaded_get(araba).instantiate()
	yaris_node.call_deferred("add_child",araba_node)
	yaris_node.player = araba_node
	araba_node.position.z = - 15
	araba_node.position.x = - 3
	araba_node.position.y = 10

	if mod == "Yaris":
		var bot_node : Node = ResourceLoader.load_threaded_get(bot_tscn).instantiate()
		yaris_node.call_deferred("add_child",bot_node)
		bot_node.position.z = - 5
		bot_node.position.x = 3
		bot_node.kirmizi = true
		bot_node.player = araba
		yaris_node.bot = bot_node
	yuklemetext.text = tr("yuklemetamam")

	var tween : Tween = create_tween()
	tween.tween_property(
		self, "position", Vector2(0, 720), 1
	).set_trans(Tween.TRANS_QUINT)
	tween.tween_callback(_on_Tween_tween_completed)

func _on_Tween_tween_completed():
	call_deferred("queue_free")
	pass
