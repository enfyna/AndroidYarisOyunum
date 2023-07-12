extends Control
var kayit = {
		"para": {"para":0,"bronz":100,"gumus":100,"altin":100,"elmas":100},

		"pistler":{"Pist01":0,"Pist02":0, "Pist03":0, "Pist04":0, "Pist05":0, "Pist06":0, 
"Pist07":0,"Pist08":0,"Pist09":0,"Pist00":0,"Pist10":0,"Pist11":0,"Pist12":0,},

		"pistsure":{"PistTest01":0,"Pist01":0,"Pist02":0, "Pist03":0, "Pist04":0, "Pist05":0, "Pist06":0, 
"Pist07":0,"Pist08":0,"Pist09":0,"Pist00":0,"Pist10":0,"Pist11":0,"Pist12":0,},

		"arabalar":{"ae86":{"sahiplik":false},"tico":{"sahiplik":false}},

		"tekerlekler":{"c5":1,"c3":1,"c1":1,"konfor":1,"yag":100,"motor":100},

		"ayarlar":{"oto":0,"hassasiyet":1.0,"sis":0,"input":0,"muzik":1,"koyu":0,"kmh":0},

		"tutorial":{"giris":0,"market":0},

		"basarimlar":{"b1":{"ilerleme":0,"odul":false},"b2":{"ilerleme":0,"odul":false},"b3":{"ilerleme":0,"odul":false}
		,"b4":{"ilerleme":0,"odul":false},"b5":{"ilerleme":0,"odul":false},"b6":{"ilerleme":0,"odul":false}
		,"b7":{"ilerleme":0,"odul":false},"b8":{"ilerleme":0,"odul":false},"b9":{"ilerleme":0,"odul":false},"b10":{"ilerleme":0,"odul":false}},

		"tarih":{"tarih":OS.get_date(),"toplamoynamasure":0,"secilengorev":{"1":1,"2":2,"3":3,"4":false,"5":false}},

		"oyuncu":{"lvl":0,"xp":0,"seciliaraba":"","isim":""},

		"gorev":{   "0" :{"odul":10000,"hedef":1 ,"tamam":false,"yap":0},
					"1" :{"odul":10000,"hedef":1 ,"tamam":false,"yap":0},
					"2" :{"odul":1000,"hedef":10,"tamam":false,"yap":0},
					"3" :{"odul":1000,"hedef":2 ,"tamam":false,"yap":0},
					"4" :{"odul":10000,"hedef":5 ,"tamam":false,"yap":0},
					"5" :{"odul":5000,"hedef":2 ,"tamam":false,"yap":0},
					"6" :{"odul":2000,"hedef":2 ,"tamam":false,"yap":0},
					"7" :{"odul":1000,"hedef":2 ,"tamam":false,"yap":0},
					"8" :{"odul":10000,"hedef":5 ,"tamam":false,"yap":0},
					"9" :{"odul":1000,"hedef":5 ,"tamam":false,"yap":0},
					"10":{"odul":10000,"hedef":15 ,"tamam":false,"yap":0},
					},
		
	}
######################################
func oyunkaydet():
	var save_path = "user://save.dat"
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "sifre")
	if error == OK:
		file.store_var(kayit)
		file.close()
	else:
		print("Dosya kaydedilemedi!")
		print("Hata : " + str(error))
##############################
func oyuncuseviye(m):
	kayit["oyuncu"]["xp"] += (m*5)
	while kayit["oyuncu"]["xp"] >= 500:
		kayit["oyuncu"]["lvl"] += 1
		kayit["oyuncu"]["xp"] -= 500
		kayit["para"]["para"] += kayit["oyuncu"]["lvl"] * 100
##############################
func toplamoynamasuresi():
		var _err = get_tree().create_timer(5).connect("timeout", Callable(self, "surearttir"))
func surearttir():
	kayit["tarih"]["toplamoynamasure"] += 5 #saniye
	toplamoynamasuresi()
	#print(kayit["tarih"]["toplamoynamasure"])
##############################
func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST)\
	and get_tree().get_current_scene() != null:
		var sahne = str(get_tree().get_current_scene().name)
		if sahne != "AnaMenu" and (sahne != "Yaris") and (sahne != "Giris") and (sahne != "YarisBitir"):
			var silinecek = get_tree().get_current_scene()
			var t = load("res://tscndosyalari/menu/AnaMenu.tscn").instantiate()
			get_parent().call_deferred("add_sibling",get_node("/root/Global"),t)
			get_tree().call_deferred("set_current_scene",t)
			silinecek.call_deferred("free")
		elif sahne == "AnaMenu":
			var t = load("res://tscndosyalari/menu/Cikis.tscn").instantiate()
			get_parent().call_deferred("add_child",t)
		elif sahne == "Yaris":
			get_parent().get_node("/root/Pause").pause()
			pass
		oyunkaydet()
######################Arkaplan Muzik ve Buton sesleri
func _ready():
	arkaplanmuzikn = AudioStreamPlayer.new()
	arkaplanmuzikn.name = "arkaplanmuzikn"
	arkaplanmuzikn.volume_db = -80
	arkaplanmuzikn.connect("finished", Callable(self, "_on_arkaplanmuzik_finished"))
	get_parent().get_node("/root/Global").call_deferred("add_child",arkaplanmuzikn)
var muzik = ""
func calinanmuzik():
	return muzik
var muzikler = [
	'res://muzik/arkaplan/jazz/Kevin MacLeod-Airport Lounge.ogg',
	'res://muzik/arkaplan/jazz/Kevin MacLeod-Deuces.ogg',
	'res://muzik/arkaplan/jazz/Kevin MacLeod-Dirt Rhodes.ogg',
	'res://muzik/arkaplan/jazz/Kevin MacLeod-Hustle.ogg',
	'res://muzik/arkaplan/jazz/Kevin MacLeod-Samba Isobel.ogg'
	]
var arkaplanmuzikn
func ackapat(t = null):
	var tween = get_tree().create_tween()
	var node = arkaplanmuzikn
	var sesdb = 0
	if t == null:
		if kayit["ayarlar"]["muzik"]:
			tween.tween_property(node,"volume_db",float(sesdb),1)
		else:
			tween.tween_property(node,"volume_db",-80.0,1)
	elif t == false:
		tween.tween_property(node,"volume_db",-80.0,1)
	elif t == true:
		tween.tween_property(node,"volume_db",float(sesdb),1)
var rsayi : int
func arkaplanmuzik():
	randomize()
	var rsayiyeni = randi() % muzikler.size()
	while rsayi == rsayiyeni :
		rsayiyeni = randi() % muzikler.size()
	muzik = str(muzikler[rsayiyeni])
	arkaplanmuzikn.stream = load(muzik)
	arkaplanmuzikn.play()
	rsayi = rsayiyeni
	if get_tree().get_current_scene().get_node_or_null("ParaTablo") != null:
		get_tree().get_current_scene().get_node("ParaTablo").muzikstrayarla()
func _on_arkaplanmuzik_finished():
	arkaplanmuzik()
func oynat(ses):
	var node = AudioStreamPlayer.new()
	node.connect("finished", Callable(node, "queue_free"))
	node.volume_db = 0
	if ses == "buton" or ses == "click":
		node.stream = load("res://muzik/uisounds/clicksound.ogg")
	else:
		node.stream = load(ses)
	add_child(node)
	node.play()
	pass
##############################





# warning-ignore:unused_class_variable
"""var pistodul = {"p1":[50000,60000,70000],
				"p2":[50000,60000,70000], 
				"p3":[50000,55000,60000], 
				"p4":[50000,60000,70000], 
				"p5":[50000,60000,70000], 
				"p6":[50000,60000,70000], 
				"p7":[50000,60000,70000], 
				"p8":[50000,60000,70000], 
				"p9":[50000,60000,70000], 
				"p0":[50000,60000,70000], 
				"p10":[50000,60000,70000],
				"p11":[50000,60000,70000],
				"p12":[50000,60000,70000],} 
"""
"""var data = {
		"para": para,
		"pistler":sahipolunanpistler,
		"arabalar":sahipolunanarabalar,
		"pistsure":pisteniyisure,
		"seciliaraba":secilenaraba,
		"tekerlekler":sahipolunantekerlekler,
		"ayarlar":ayarlar,
		"xp":xp,
		"isim":isim,
		"tutorial":tutorial,
		"basarimlar":basarimlar,
		"zaman":anlikoynamasuresi,
		"tarih":tarih,
		"gorev":gorev,
		"secilengorev":secilengorev,
		"oyunsurum":oyunsurum
	}"""
#######kaydedilmesi gereken degerler
#var basarimlar = {"b1":0,"b2":0,"b3":0,"b4":0,"b5":0,"b6":0,"b7":0,"b8":0,"b9":0,"b10":0}
#var para = {"para":0,"bronz":0,"gumus":0,"altin":0,"elmas":0}
#var sahipolunanpistler = {"p1":0,"p2":0, "p3":0, "p4":0, "p5":0, "p6":0, 
#"p7":0,"p8":0,"p9":0,"p0":0,"p10":0,"p11":0,"p12":0,}
#var pisteniyisure = {"p1":0,"p2":0, "p3":0, "p4":0, "p5":0, "p6":0, 
#"p7":0,"p8":0,"p9":0,"p0":0,"p10":0,"p11":0,"p12":0,} 
#var sahipolunanarabalar = {"ae86":0,"tico":0}
#var sahipolunantekerlekler = {"c5":1,"c3":1,"c1":1,"konfor":1,"yag":100,"motor":100}
"""var gorev = {   "1" :{"odul":10000,"hedef":1 ,"tamam":false,"yap":0},
				"2" :{"odul":1000,"hedef":10,"tamam":false,"yap":0},
				"3" :{"odul":1000,"hedef":2 ,"tamam":false,"yap":0},
				"4" :{"odul":10000,"hedef":5 ,"tamam":false,"yap":0},
				"5" :{"odul":5000,"hedef":2 ,"tamam":false,"yap":0},
				"6" :{"odul":2000,"hedef":2 ,"tamam":false,"yap":0},
				"7" :{"odul":1000,"hedef":2 ,"tamam":false,"yap":0},
				"8" :{"odul":10000,"hedef":5 ,"tamam":false,"yap":0},
				"9" :{"odul":1000,"hedef":5 ,"tamam":false,"yap":0},
				"10":{"odul":10000,"hedef":15 ,"tamam":false,"yap":0},
				}"""
#var secilengorev = {"1":1,"2":2,"3":3,"4":false,"5":false}
#var tarih = {"tarih":OS.get_date(),"toplamoynamasure":0,"secilengorev":secilengorev}
#var ayarlar = {"oto":0,"hassasiyet":1,"sis":0,"input":0,"muzik":1,"koyu":0,"kmh":0}
#var oyuncu = {"lvl":0,"xp":0,"seciliaraba":"","isim":""}
#var tutorial = {"giris":0}
#var oturumsure = 0
#var toplamoynamasure = 1
# warning-ignore:unused_class_variable
#var muzikac = 0 #sarkiyi durdurmak icin
