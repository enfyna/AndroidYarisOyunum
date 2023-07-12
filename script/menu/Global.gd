extends Control

var kayit = {
		"para":{"para":0, "bronz":100, "gumus":100, "altin":100, "elmas":100}, 

		"pistler":{"Pist01":0, "Pist02":0, "Pist03":0, "Pist04":0, "Pist05":0, "Pist06":0, 
"Pist07":0, "Pist08":0, "Pist09":0, "Pist00":0, "Pist10":0, "Pist11":0, "Pist12":0, }, 

		"pistsure":{"PistTest01":0, "Pist01":0, "Pist02":0, "Pist03":0, "Pist04":0, "Pist05":0, "Pist06":0, 
"Pist07":0, "Pist08":0, "Pist09":0, "Pist00":0, "Pist10":0, "Pist11":0, "Pist12":0, }, 

		"arabalar":{"ae86":{"sahiplik":false}, "tico":{"sahiplik":false}}, 

		"tekerlekler":{"c5":1, "c3":1, "c1":1, "konfor":1, "yag":100, "motor":100}, 

		"ayarlar":{"oto":0, "hassasiyet":1, "sis":0, "input":0, "muzik":1, "koyu":0, "kmh":0}, 

		"tutorial":{"giris":0}, 

		"basarimlar":{"b1":{"ilerleme":0, "odul":false}, "b2":{"ilerleme":0, "odul":false}, "b3":{"ilerleme":0, "odul":false}
		, "b4":{"ilerleme":0, "odul":false}, "b5":{"ilerleme":0, "odul":false}, "b6":{"ilerleme":0, "odul":false}
		, "b7":{"ilerleme":0, "odul":false}, "b8":{"ilerleme":0, "odul":false}, "b9":{"ilerleme":0, "odul":false}, "b10":{"ilerleme":0, "odul":false}}, 

		"tarih":{"tarih":OS.get_date(), "toplamoynamasure":0, "secilengorev":{"1":1, "2":2, "3":3, "4":false, "5":false}}, 

		"oyuncu":{"lvl":0, "xp":0, "seciliaraba":"", "isim":""}, 

		"gorev":{"1":{"odul":10000, "hedef":1, "tamam":false, "yap":0}, 
					"2":{"odul":1000, "hedef":10, "tamam":false, "yap":0}, 
					"3":{"odul":1000, "hedef":2, "tamam":false, "yap":0}, 
					"4":{"odul":10000, "hedef":5, "tamam":false, "yap":0}, 
					"5":{"odul":5000, "hedef":2, "tamam":false, "yap":0}, 
					"6":{"odul":2000, "hedef":2, "tamam":false, "yap":0}, 
					"7":{"odul":1000, "hedef":2, "tamam":false, "yap":0}, 
					"8":{"odul":10000, "hedef":5, "tamam":false, "yap":0}, 
					"9":{"odul":1000, "hedef":5, "tamam":false, "yap":0}, 
					"10":{"odul":10000, "hedef":15, "tamam":false, "yap":0}, 
					}, 
		
	}

func oyunkaydet():
	var save_path = "user://save.dat"
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "sifre")
	if error == OK:
		file.store_var(kayit)
		file.close()
	else :
		print("Dosya kaydedilemedi!")
		print("Hata : " + str(error))

func oyuncuseviye(m):
	if (kayit["oyuncu"]["lvl"] - (kayit["oyuncu"]["lvl"] % 10)) / 10 >= 1:
		kayit["oyuncu"]["xp"] += (m * 5) / ((kayit["oyuncu"]["lvl"] - (kayit["oyuncu"]["lvl"] % 10)) / 10)
	else :
		kayit["oyuncu"]["xp"] += m * 5
	while kayit["oyuncu"]["xp"] >= 500:
		kayit["oyuncu"]["lvl"] += 1
		kayit["oyuncu"]["xp"] -= 500
		kayit["para"]["para"] += kayit["oyuncu"]["lvl"] * 100

func toplamoynamasuresi():
		var _err = get_tree().create_timer(5).connect("timeout", self, "surearttir")
func surearttir():
	kayit["tarih"]["toplamoynamasure"] += 5000
	toplamoynamasuresi()
	

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST) and get_tree().get_current_scene() != null:
		var sahne = str(get_tree().get_current_scene().name)
		if sahne != "AnaMenu" and (sahne != "Yaris") and (sahne != "Giris") and (sahne != "YarisBitir"):
			var silinecek = get_tree().get_current_scene()
			var t = load("res://tscndosyalari/menu/AnaMenu.tscn").instance()
			get_parent().call_deferred("add_child_below_node", get_node("/root/Arkaplanmuzik"), t)
			
			get_tree().call_deferred("set_current_scene", t)
			
			
			silinecek.call_deferred("free")
		elif sahne == "AnaMenu":
			oyunkaydet()
			var t = load("res://tscndosyalari/menu/Cikis.tscn").instance()
			get_parent().call_deferred("add_child", t)
		elif sahne == "Yaris":
			get_parent().get_node("/root/Pause").pause()
			pass




"var pistodul = {\"p1\":[50000,60000,70000],\n				\"p2\":[50000,60000,70000], \n				\"p3\":[50000,55000,60000], \n				\"p4\":[50000,60000,70000], \n				\"p5\":[50000,60000,70000], \n				\"p6\":[50000,60000,70000], \n				\"p7\":[50000,60000,70000], \n				\"p8\":[50000,60000,70000], \n				\"p9\":[50000,60000,70000], \n				\"p0\":[50000,60000,70000], \n				\"p10\":[50000,60000,70000],\n				\"p11\":[50000,60000,70000],\n				\"p12\":[50000,60000,70000],} \n"
"var data = {\n		\"para\": para,\n		\"pistler\":sahipolunanpistler,\n		\"arabalar\":sahipolunanarabalar,\n		\"pistsure\":pisteniyisure,\n		\"seciliaraba\":secilenaraba,\n		\"tekerlekler\":sahipolunantekerlekler,\n		\"ayarlar\":ayarlar,\n		\"xp\":xp,\n		\"isim\":isim,\n		\"tutorial\":tutorial,\n		\"basarimlar\":basarimlar,\n		\"zaman\":anlikoynamasuresi,\n		\"tarih\":tarih,\n		\"gorev\":gorev,\n		\"secilengorev\":secilengorev,\n		\"oyunsurum\":oyunsurum\n	}"









"var gorev = {   \"1\" :{\"odul\":10000,\"hedef\":1 ,\"tamam\":false,\"yap\":0},\n				\"2\" :{\"odul\":1000,\"hedef\":10,\"tamam\":false,\"yap\":0},\n				\"3\" :{\"odul\":1000,\"hedef\":2 ,\"tamam\":false,\"yap\":0},\n				\"4\" :{\"odul\":10000,\"hedef\":5 ,\"tamam\":false,\"yap\":0},\n				\"5\" :{\"odul\":5000,\"hedef\":2 ,\"tamam\":false,\"yap\":0},\n				\"6\" :{\"odul\":2000,\"hedef\":2 ,\"tamam\":false,\"yap\":0},\n				\"7\" :{\"odul\":1000,\"hedef\":2 ,\"tamam\":false,\"yap\":0},\n				\"8\" :{\"odul\":10000,\"hedef\":5 ,\"tamam\":false,\"yap\":0},\n				\"9\" :{\"odul\":1000,\"hedef\":5 ,\"tamam\":false,\"yap\":0},\n				\"10\":{\"odul\":10000,\"hedef\":15 ,\"tamam\":false,\"yap\":0},\n				}"









