extends Spatial
onready var eniyisurelabel = $Eniyisure/Eniyisure
onready var sonturlabel = $SonTur/SonTur
onready var surelabel = $Sure/Sure
onready var turlabel =  $Tur/Tur
var tur = 0 ; var bottur = 0 ; var yaristur = 0
var ms = 0 ; var dakika = 0 ; var saniye = 0
var sontursurestr ; var sontursureint
var altin ; var gumus ; var bronz 
var test = false ; var mod : String #Yaris - Zaman 
var player ; var bot
var kazanmabonusu
var pisteniyisure
var yarispist
var pistindex = 0
var toplamsure = 0 #ms biriminde
var penaltitur = 0
var gecenzaman
var kontrol = 1
var pistodul = {
				"PistTest01":[50000,60000,70000],
				"PistTest02":[50000,60000,70000],
				"Pist00":[50000,60000,70000],
				"Pist01":[50000,60000,70000],
				"Pist02":[50000,60000,70000], 
				"Pist03":[50000,55000,60000], 
				"Pist04":[50000,60000,70000], 
				"Pist05":[50000,60000,70000], 
				"Pist06":[50000,60000,70000], 
				"Pist07":[50000,60000,70000], 
				"Pist08":[50000,60000,70000], 
				"Pist09":[50000,60000,70000],  
				"Pist10":[50000,60000,70000],
				"Pist11":[50000,60000,70000],
				"Pist12":[50000,60000,70000],
				} 

func _ready():
	var index = AudioServer.get_bus_channels(1)
	AudioServer.set_bus_effect_enabled(index,0,false)
	$DirectionalLight.shadow_enabled = true if Global.kayit["ayarlar"]["sis"] else false
	Global.ackapat(false)
	$Penalti.visible = 0
	sureturyazisiguncelle("ready")

func pistindexayarla():
	pistindex = str(yarispist.name)
	var sure
	if not mod == "Zaman" or test:
		$pst.call_deferred("free")
	else:
		altin = pistodul[pistindex][0]
		ms = int(altin%1000)
		saniye = int((altin/1000)%60)
		dakika = int((altin/60000)%60)
		sure = "%01d'%02d.%03d" %[dakika,saniye,ms]
		$pst/v/altin.text = sure
		gumus = pistodul[pistindex][1] 
		ms = int(gumus%1000)
		saniye = int((gumus/1000)%60)
		dakika = int((gumus/60000)%60)
		sure = "%01d'%02d.%03d" %[dakika,saniye,ms]
		$pst/v/gumus.text = sure
		bronz = pistodul[pistindex][2]
		ms = int(bronz%1000)
		saniye = int((bronz/1000)%60)
		dakika = int((bronz/60000)%60)
		sure = "%01d'%02d.%03d" %[dakika,saniye,ms]
		$pst/v/bronz.text = sure
	pisteniyisure = Global.kayit["pistsure"][pistindex]
	ms = 0 ; saniye = 0 ; dakika = 0
	eniyituryazisiguncelle()


func _process(delta):
	gecenzamanguncelle(delta)
func gecenzamanguncelle(delta):
	ms += delta*1000
	if ms >= 1000:
		saniye += 1
		ms = 0
	if saniye >= 60:
		dakika += 1
		saniye = 0
	gecenzaman = "%01d'%02d.%03d"%[dakika,saniye,ms]
	surelabel.text = gecenzaman

#func gecenzamanguncelle(delta):
	#zaman += int(delta * 1000) #ms
	#ms = zaman%1000
	#saniye = (zaman/1000)%60
	#dakika = (zaman/60000)%60
	#gecenzaman = "%01d'%02d.%03d"%[dakika,saniye,ms]
	#surelabel.text = gecenzaman

func _on_cizgi_body_entered(body):
	if body == player:
		Global.oyunkaydet()
		player.tekerlekdurum(tur)
		sontursureint = int(dakika*60000 + saniye*1000 + ms)
		sontursurestr = gecenzaman
		toplamsure += sontursureint
		if kontrol == 2 or tur == 0:
			ms = 0;saniye = 0;dakika = 0#;zaman = 0
			if penaltitur != tur and pistindex != null:
				odulver(pistindex)
			elif penaltitur == tur:
				turlabel.add_color_override("font_color",Color(1,1,1,1))
				surelabel.add_color_override("font_color",Color(1,1,1,1))
			tur += 1
		else: #Cizgiden ters gecme durumu
			tur -= 1
			penalti(1)
		kontrol = 0
		sureturyazisiguncelle("player")
	elif body == bot:
		bottur += 1
		sureturyazisiguncelle("bot")
	
	if (tur > yaristur or bottur > yaristur) and mod == "Yaris":
		if tur > bottur:
			Global.kayit["gorev"]["3"]["yap"] += 1
			Global.kayit["gorev"]["8"]["yap"] += 1
			yarisbitir("Kazandın!")
		else:
			yarisbitir("Kaybettin.")
		$cizgi/CollisionShape.disabled = true
		pass
	pass

func _on_kontrol_body_entered(body):
	if body == player and kontrol == 0:
		kontrol = 1
func _on_kontrol2_body_entered(body):
	if body == player and kontrol == 1: 
		kontrol = 2

onready var Penalti = $Penalti
func penalti(i):
	var ceza = [100,1000,300]
	penaltitur = tur
	turlabel.add_color_override("font_color",Color(1,0,0,1))
	surelabel.add_color_override("font_color",Color(1,0,0,1))
	if   i == 0:
		Penalti.visible = true
		Penalti.text = tr("p1")+"\n"+tr("penalti")+":"+str(ceza[0])+" "+tr("para")
		Global.kayit["para"]["para"] -= ceza[0]
		toplamodulp -= ceza[0]
	elif i == 1:
		Penalti.visible = true
		Penalti.text = tr("p2")+"\n"+tr("penalti")+":"+str(ceza[1])+" "+tr("para")
		Global.kayit["para"]["para"] -= ceza[1]
		toplamodulp -= ceza[1]
	elif i == 2:
		Penalti.visible = true
		Penalti.text = tr("p3")+"\n"+tr("penalti")+":"+str(ceza[2])+" "+tr("para")
		Global.kayit["para"]["para"] -= ceza[2]
		toplamodulp -= ceza[2]
	$Timer.start(3); yield($Timer, "timeout")
	Penalti.visible = false
	Penalti.text = ""

func eniyituryazisiguncelle():
	if mod == "Zaman" and not test:
		if pisteniyisure == 0:
			eniyisurelabel.text = "-"
		else:
	# warning-ignore:integer_division
			eniyisurelabel.text = str(int(pisteniyisure/60000)) + ":" + str(int(pisteniyisure % 60000)/1000).pad_zeros(2) + "." + str(pisteniyisure%1000).pad_zeros(3)
	else:
		$Eniyisure.visible = false

func sureturyazisiguncelle(kim):
	if kim == "player":
		if mod == "Zaman":
			turlabel.text = str(tur) if tur > bottur else str(bottur)
		else:
			turlabel.text = str(str(tur)+"/"+str(yaristur)) if tur > bottur else str(str(bottur)+"/"+str(yaristur))
			if tur > yaristur or bottur > yaristur:
				turlabel.text = str(yaristur)+"/"+str(yaristur)
		sonturlabel.text = sontursurestr
	elif kim == "bot":
		turlabel.text = str(str(tur)+"/"+str(yaristur)) if tur > bottur else str(str(bottur)+"/"+str(yaristur))
	elif kim == "ready":
		if mod == "Zaman":
			turlabel.text = "1"
		else:
			turlabel.text = str("1/"+str(yaristur))
		sonturlabel.text = "-"

func kirmiziisik():
	var ust = $kirmiziisikust
	var alt = $kirmiziisikalt
	var yesil = $yesilisik
	var sari = $sariisik
	var ses = $SetReadyGo
	var setready = "res://muzik/uisounds/setready.ogg"
	var go = "res://muzik/uisounds/Go.ogg"
	ses.stream = load(setready)
	yesil.visible = false;sari.visible = false;ust.visible = false;alt.visible = false
	$Timer.start(2); yield($Timer, "timeout")
	ses.play()
	alt.visible = true
	$Timer.start(1); yield($Timer, "timeout")
	ses.play()
	ust.visible = true
	$Timer.start(1); yield($Timer, "timeout")
	ses.connect("finished",ses,"queue_free")
	if typeof(player) == TYPE_OBJECT and player.speed > 1:
		penalti(2)
	ses.stream = load(go)
	ses.play()
	alt.visible = false ; ust.visible = false
	if bot != null:
		bot.bekle = false
	pass

var toplamodulp = 0
var toplamodula = 0
var toplamodulb = 0
var toplamodulg = 0
func odulver(pindex):
	Global.kayit["basarimlar"]["b1"]["ilerleme"] += 1 #Tur atma basarimi
	Global.kayit["gorev"]["2"]["yap"] += 1 #Gunluk gorev
	Global.kayit["gorev"]["10"]["yap"] += 1
	Global.kayit["gorev"]["9"]["yap"] += 1
	if tur >= 1: #Tur Atma Odulu.
		Global.kayit["para"]["para"] += 100 + ((tur)*20)
		toplamodulp += 100 + ((tur)*20)
		Global.oyuncuseviye((tur-1)*2)
	if mod == "Zaman" and not test:
		if   sontursureint < altin and tur >= 1:#Altın
			Global.kayit["para"]["altin"] += 1
			toplamodula += 1
			Global.kayit["gorev"]["4"]["yap"] += 1
			Global.kayit["gorev"]["5"]["yap"] += 1
		elif sontursureint < gumus and tur >= 1:#Gümüş
			Global.kayit["para"]["gumus"] += 1
			toplamodulg += 1
			Global.kayit["gorev"]["6"]["yap"] += 1
		elif sontursureint < bronz and tur >= 1:#Bronz
			Global.kayit["para"]["bronz"] += 1
			toplamodulb += 1
			Global.kayit["gorev"]["7"]["yap"] += 1
	if test:
		Global.kayit["gorev"]["0"]["yap"] += 1
	#En iyi süreyi kaydet
	if (sontursureint < pisteniyisure or pisteniyisure == 0) and tur >=1 and mod == "Zaman":
		Global.kayit["pistsure"][pindex] = sontursureint
		pisteniyisure = sontursureint
		eniyisurelabel.text = sontursurestr
		Global.kayit["gorev"]["1"]["yap"]+= 1

func yarisbitir(durum):
	$TerkEt.visible = false
	var b = load("res://tscndosyalari/menu/YarisBitir.tscn").instance()
	if durum == "Kazandın!":
		b.kazanmabonusu = kazanmabonusu
	else: 
		b.kazanmabonusu = 0
	b.durum = durum
	b.para = toplamodulp
	b.altin = toplamodula
	b.gumus = toplamodulg
	b.bronz = toplamodulb
	b.sure = toplamsure
	b.tur = yaristur if mod == "Yaris" else tur-1
	b.mod = mod
	get_parent().call_deferred("add_child_below_node",get_parent().get_node("/root/Yaris"),b)
	pass

func _on_TerkEt_pressed():
	if mod == "Zaman":
		yarisbitir("Zamana Karşı!")
	elif mod == "Yaris":
		yarisbitir("Kaybettin.")
	pass 

func _on_pst_toggled(button_pressed):
	$pst.modulate = Color(1,1,1,1) if button_pressed else Color(0,0,0,0)


