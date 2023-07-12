extends Control
var muzikayari = Global.kayit["ayarlar"]["muzik"]
@onready var muzik = $muzik
var muzikstr
var muziksil
@onready var paralar = $paralar
@onready var paralabel = $paralar/para/para
@onready var bronzlabel = $paralar/b/b
@onready var gumuslabel = $paralar/g/g
@onready var altinlabel = $paralar/a/a
@onready var elmaslabel = $paralar/e/e
var para  = Global.kayit["para"]["para"]
var sira = 1
var artieksi = "+"
var r = 1
var tamamlanmisgorevvar = false
@onready var isim = $isim
@onready var tween = $Tween
@onready var gorevnode = $isim/Gorev
var gorevkonum = -504
var kontrol = 0
var reklamtip 
@onready var admob = $AdMob
var gorevbaslik = {"0" :tr("gg0"),
				   "1" :tr("gg1"),
				   "2" :tr("gg2"),
				   "3" :tr("gg3"),
				   "4" :tr("gg4"),
				   "5" :tr("gg5"),
				   "6" :tr("gg6"),
				   "7" :tr("gg7"),
				   "8" :tr("gg8"),
				   "9" :tr("gg9"),
				   "10":tr("gg10")
				}
var reklamgorev = {"4":tr("rg1"),
				   "5":tr("rg2")}
var parakonumyeni
var goster = ["AnaMenu","Market","Giris","Galeri","PistSatinAl"]
func _ready():
	muzikstrayarla()
	$isim.text = Global.kayit["oyuncu"]["isim"]
	$isim/Level.xparttir()
	var sahne = str(get_tree().get_current_scene().name)
	# ready fonksiyonu sahne oyuna girmeden once cagirildigi 
	# icin get_current_scene fonksiyonu onceki sahnenin adini verir
	paralar.position.y = 656 if goster.has(sahne) else 756
	muzik.position.y = 756 if goster.has(sahne) else 656
	sahne = str(get_parent().name)
	# girecegimiz sahnenin adi   
	parakonumyeni = true if goster.has(sahne) else false
	gunlukgorevler()
	muziklabelkaydir()
	paralabelguncelle()
	paralabelkaydir()
	isimyanson(tamamlanmisgorevvar)
	$isim/Gorev/v/Baslik.text = tr("gunlukgorev")
	$Timer.start(0.1)

func muzikstrayarla():
	muzikstr = str(Global.calinanmuzik())
	muzikstr.erase(0,26)
	muzikstr.erase(muzikstr.length() - 4 ,4)
	muzikstr = muzikstr + " /// " + muzikstr + " /// " + muzikstr
	muziksil = str(muzikstr)
func paralabelguncelle():
	bronzlabel.text = str(Global.kayit["para"]["bronz"]) #bronz
	gumuslabel.text = str(Global.kayit["para"]["gumus"]) #gumus
	altinlabel.text = str(Global.kayit["para"]["altin"]) #altin
	elmaslabel.text = str(Global.kayit["para"]["elmas"]) #elmas
	if para < Global.kayit["para"]["para"]:
		artieksi = "+"
		tween.interpolate_property(get_node("."),"para",
		null, Global.kayit["para"]["para"]
		,1,Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		tween.start()
	elif para > Global.kayit["para"]["para"]:
		artieksi = "-"
		tween.interpolate_property(get_node("."),"para",
		null, Global.kayit["para"]["para"]
		,1,Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		tween.start()
	else:
		paralabel.text =  str(Global.kayit["para"]["para"])
	pass

func _on_Tween_tween_step(_object, key, _elapsed, _value):
	if key == ":para":
		paralabel.text  =  str(artieksi,int(para))
		pass
	pass 
func _on_Tween_tween_completed(_object, key):
	if key == ":para":
		paralabel.text  =  str(int(para))
		pass
	pass 
func paralabelkaydir():
		if parakonumyeni:
			tween.interpolate_property(paralar,"position",
			Vector2(928,paralar.position.y), Vector2(928,656)
			, 0.5,Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
			tween.start()
		if not parakonumyeni:
			tween.interpolate_property(paralar,"position",
			Vector2(928,paralar.position.y), Vector2(928,756)
			, 0.5,Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
			tween.start()
		pass

func muziklabelkaydir():
		if muzikayari:
			if parakonumyeni:
				tween.interpolate_property(muzik,"position",
				Vector2(928,muzik.position.y), Vector2(928,756)
				, 0.5,Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
				tween.start()
			elif not parakonumyeni:
				tween.interpolate_property(muzik,"position",
				Vector2(928,muzik.position.y), Vector2(928,656)
				, 0.5,Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
				tween.start()
		elif not muzikayari:
			muzik.position.y = 756

@onready var tween2 = $Tween2
func isimyanson(b):
	if b == true:
		r = 0.5
		isim.add_theme_color_override("font_color",Color(r,r,r,1))
		tween2.interpolate_property(isim,"theme_override_colors/font_color",
		null, Color(1,1,1,1)
		,2,Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		tween2.start()
	elif b == false:
		isim.add_theme_color_override("font_color",Color(1,1,1,1))
	pass
func muzikkaydir():
		muziksil.erase(0,1)
		if muziksil.length() == muzikstr.length()/3:
			muziksil = str(muzikstr)
		muzik.text = " "+tr("muzik")+": " + muziksil
func _on_Timer_timeout():
	muzikkaydir()
	pass 

func gunlukgorevler():
	sira = 1
	var gunlukgorevsayisi = 3
	for i in range(gunlukgorevsayisi):
		var x = Global.kayit["tarih"]["secilengorev"][str(i+1)]
		var baslik = get_node("isim/Gorev/v/s/v/Gorev"+str(sira))
		var bar = get_node("isim/Gorev/v/s/v/Gorev"+str(sira)+"/bar")
		var buton = get_node("isim/Gorev/v/s/v/Gorev"+str(sira)+"/b"+str(sira))
		var stylbx = baslik.get_stylebox("normal").duplicate()
		if not Global.kayit["gorev"][str(x)]["tamam"]:
			if i == 2 and Global.kayit["oyuncu"]["lvl"] < 5:
				stylbx.bg_color = Color(0,0.4,0.4,0.5)
				baslik.text = tr("level5")
				bar.visible = false
				buton.visible = false
			else:
				if Global.kayit["gorev"][str(x)]["yap"] < Global.kayit["gorev"][str(x)]["hedef"]:
					bar.visible = true
					bar.value = Global.kayit["gorev"][str(x)]["yap"]*(100/Global.kayit["gorev"][str(x)]["hedef"])
					buton.visible = false
				elif Global.kayit["gorev"][str(x)]["yap"] >= Global.kayit["gorev"][str(x)]["hedef"]:
					bar.visible = false
					buton.visible = true
					tamamlanmisgorevvar = true
				var odul = Global.kayit["gorev"][str(x)]["odul"]
				if odul >= 10000:
					stylbx.bg_color = Color(0,1,1,0.5)
				elif odul >= 5000:
					stylbx.bg_color = Color(0.9,1,0,0.5)
				elif odul >= 2000:
					stylbx.bg_color = Color(0.3,0.3,0.3,0.5)
				baslik.text = gorevbaslik[str(x)] +"\n"+ tr("ggodul")%[odul]
			baslik.custom_minimum_size.y = 150 +(max(0,baslik.get_line_count()-2)*50)
		else:
			stylbx.bg_color = Color(0,1,0,0.5)
			baslik.text = tr("gorevtamam")
			bar.visible = false
			buton.visible = false
		baslik.add_theme_stylebox_override("normal",stylbx)
		sira += 1
	var reklamsayisi = 2
	for _i in range(reklamsayisi):
		var baslik = get_node("isim/Gorev/v/s/v/Gorev"+str(sira))
		var reklambuton = get_node("isim/Gorev/v/s/v/Gorev"+str(sira)+"/r"+str(sira))
		var stylbx = baslik.get_stylebox("normal").duplicate()
		if Global.kayit["oyuncu"]["lvl"] < 10:
			baslik.text = tr("level10")
			stylbx.bg_color = Color(0,0.4,0.4,0.5)
			reklambuton.visible = false
		elif not Global.kayit["tarih"]["secilengorev"][str(sira)]:
			stylbx.bg_color = Color(0.5,0,0,0.5)
			baslik.text = reklamgorev[str(sira)]
			reklambuton.visible = true
			reklambuton.text = tr("izle")
			tamamlanmisgorevvar = true
		else:
			baslik.text = tr("gorevtamam")
			stylbx.bg_color = Color(0,1,0,0.5)
			reklambuton.visible = false
		baslik.add_theme_stylebox_override("normal",stylbx)
		sira += 1
		pass
	isimyanson(tamamlanmisgorevvar)

func _on_isim_toggled(button_pressed):
	if button_pressed == true:
		gorevkonum = 0
		tween.interpolate_property(gorevnode,"position",
		null, Vector2(0,-656)
		,0.5,Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		tween.start()
	else:
		tween.interpolate_property(gorevnode,"position",
		null, Vector2(-504,-656)
		,0.5,Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		tween.start()
	pass

func _on_b1_pressed():
	Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"]["1"])]["tamam"] = true
	Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"]["1"])]["yap"] = 0
	Global.kayit["para"]["para"] += Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"]["1"])]["odul"]
	paralabelguncelle()
	gunlukgorevler()
func _on_b2_pressed():
	Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"]["2"])]["tamam"] = true
	Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"]["2"])]["yap"] = 0
	Global.kayit["para"]["para"] += Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"]["2"])]["odul"]
	paralabelguncelle()
	gunlukgorevler()
func _on_b3_pressed():
	Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"]["3"])]["tamam"] = true
	Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"]["3"])]["yap"] = 0
	Global.kayit["para"]["para"] += Global.kayit["gorev"][str(Global.kayit["tarih"]["secilengorev"]["3"])]["odul"]
	paralabelguncelle()
	gunlukgorevler()
##############################################ADMOB
func _on_r4_pressed():
	kontrol += 1
	if kontrol ==1:
		$isim/Gorev/v/s/v/Gorev4/r4.text = tr("yukleniyor")
		reklamtip = 4
		odullureklamgoster("ca-app-pub-9739592964869796/3495857188")
	pass
func _on_r5_pressed():
	kontrol += 1
	if kontrol ==1:
		$isim/Gorev/v/s/v/Gorev5/r5.text = tr("yukleniyor")
		reklamtip = 5
		odullureklamgoster("ca-app-pub-9739592964869796/9609268572")
	pass
func odullureklamgoster(id):
	admob.rewarded_id = id
	admob.load_rewarded_video()
	pass
func _on_AdMob_rewarded_video_loaded():
	admob.show_rewarded_video()
	butonyaziguncelle(4)
	pass 
func _on_AdMob_rewarded_video_failed_to_load(error_code):
	#Error Code 0 : ERROR_CODE_INTERNAL_ERROR
	#Error Code 1 : ERROR_CODE_INVALID_REQUEST
	#Error Code 2 : ERROR_CODE_NETWORK_ERROR
	#Error Code 3 : ERROR_CODE_NO_FILL 
	butonyaziguncelle(error_code)
	pass
func _on_AdMob_rewarded(currency, amount):
	if currency == "SuperSoft":
		Global.kayit["tekerlekler"]["c5"] += amount
		Global.kayit["tarih"]["secilengorev"]["4"] = true
	elif currency == "Money":
		Global.kayit["para"]["para"] += amount
		Global.kayit["tarih"]["secilengorev"]["5"] = true
		paralabelguncelle()
	gunlukgorevler()
	pass
func butonyaziguncelle(durum):
	var id = reklamtip
	var btn = get_node("isim/Gorev/v/s/v/Gorev"+str(id)+"/r"+str(id))
	if durum == 4:
		btn.text = ""
	elif durum == 2:
		btn.text = tr("internet yok")
	else:
		btn.text = tr("rhata")
	kontrol = 0
	pass
