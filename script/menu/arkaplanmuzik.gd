extends Node
var muzik = ""
func calinanmuzik():
	return muzik
var muzikler = [
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Airport Lounge.ogg", 
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Deuces.ogg", 
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Dirt Rhodes.ogg", 
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Hustle.ogg", 
	"res://muzik/arkaplan/jazz/Kevin MacLeod-Samba Isobel.ogg"
	]

func _ready():
	arkaplanmuzik()
	
		

var sesdb = 0
onready var arkaplanmuzikn = $arkaplanmuzik

func ackapat(t = null):
	if t == null:
		if Global.kayit["ayarlar"]["muzik"]:
			arkaplanmuzikn.volume_db = sesdb
		else :
			arkaplanmuzikn.volume_db = - 80
	elif t == false:
		arkaplanmuzikn.volume_db = - 80
	elif t == true:
		arkaplanmuzikn.volume_db = sesdb
	

var rsayi:int
func arkaplanmuzik():
	randomize()
	var rsayiyeni = randi() % muzikler.size()
	while rsayi == rsayiyeni:
		rsayiyeni = randi() % muzikler.size()
	
	muzik = str(muzikler[rsayiyeni])
	arkaplanmuzikn.stream = load(muzik)
	arkaplanmuzikn.play()
	rsayi = rsayiyeni

func _on_arkaplanmuzik_finished():
	arkaplanmuzik()
	pass



	
	

