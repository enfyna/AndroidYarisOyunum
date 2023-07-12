extends Control
var parayok = tr("parayok")
var market = 0
var yazilar
var fiyat = {  "c5":5000,"c3":2000,"c1":1000,"konfor":500,
			   "elmasal":100000,"elmassat":10000,
			   "altinal":9000,"altinsat":5000,
			   "gumusal":4500,"gumussat":2000,
			   "bronzal":1500,"bronzsat":1000,
			   "yag":500,"motor":10000,
			   "1e":1,"2e":1.5,"6e":3,"12e":5,}

func yazilariguncelle():
	var c5yuzde = fmod(Global.kayit["tekerlekler"]["c5"],1) if fmod(Global.kayit["tekerlekler"]["c5"],1)!=0 or Global.kayit["tekerlekler"]["c5"] == 0 else 1.0
	var c3yuzde = fmod(Global.kayit["tekerlekler"]["c3"],1) if fmod(Global.kayit["tekerlekler"]["c3"],1)!=0 or Global.kayit["tekerlekler"]["c3"] == 0 else 1.0
	var c1yuzde = fmod(Global.kayit["tekerlekler"]["c1"],1) if fmod(Global.kayit["tekerlekler"]["c1"],1)!=0 or Global.kayit["tekerlekler"]["c1"] == 0 else 1.0
	var konforyuzde =  fmod(Global.kayit["tekerlekler"]["konfor"],1) if fmod(Global.kayit["tekerlekler"]["konfor"],1)!=0 or Global.kayit["tekerlekler"]["konfor"] == 0 else 1.0
	yazilar = {"c5":tr("mc5")+"\n"+tr("sahipolunan")+": " + str(max(0,c5yuzde)*100) + "%+"+str(max(0,ceil(Global.kayit["tekerlekler"]["c5"])-1))+"\n(%10/3.15)",
			   "c3":tr("mc3")+"\n"+tr("sahipolunan")+": " + str(max(0,c3yuzde)*100) + "%+"+str(max(0,ceil(Global.kayit["tekerlekler"]["c3"])-1))+ "\n(%5/2.83)",
			   "c1":tr("mc1")+"\n"+tr("sahipolunan")+": " + str(max(0,c1yuzde)*100) + "%+"+str(max(0,ceil(Global.kayit["tekerlekler"]["c1"])-1))+ "\n(%4/2.15)",
			   "konfor":tr("mkonfor")+"\n"+tr("sahipolunan")+": " + str(max(0,konforyuzde)*100) + "%+"+str(max(0,ceil(Global.kayit["tekerlekler"]["konfor"])-1))+ "\n(%2/1.53)",
			   "elmas":tr("melmas"),"elmasfiyat":tr("satinal")+": " +str(fiyat["elmasal"])+"\n"+tr("sat")+": "+str(fiyat["elmassat"]),
			   "altin":tr("maltin"),"altinfiyat":tr("satinal")+": "+str(fiyat["altinal"])+"\n"+tr("sat")+": "+str(fiyat["altinsat"]),
			   "gumus":tr("mgumus"),"gumusfiyat":tr("satinal")+": "+str(fiyat["gumusal"])+"\n"+tr("sat")+": "+str(fiyat["gumussat"]),
			   "bronz":tr("mbronz"),"bronzfiyat":tr("satinal")+": "+str(fiyat["bronzal"])+"\n"+tr("sat")+": "+str(fiyat["bronzsat"]),
			   "yag":tr("myag")+"\n\n"+tr("durum")+" : %" + str(int(Global.kayit["tekerlekler"]["yag"])),
			   "motor":tr("mmotor")+"\n\n"+tr("durum")+" : %" + str(int(Global.kayit["tekerlekler"]["motor"])),
			   "1e":"1 "+tr("melmas"),"2e":"2 "+tr("melmas"),"6e":"5+1 "+tr("melmas"),"12e":"10+2 "+tr("melmas"),}
func _ready():
	yazilariguncelle()
	$TabContainer.set_tab_disabled(1 ,true)
	$TabContainer.set_tab_disabled(3 ,true)
	$TabContainer.set_tab_disabled(5 ,true)
	$TabContainer.set_tab_title(0,tr("tekeral"))
	$TabContainer.set_tab_title(2,tr("elmasal"))
	$TabContainer.set_tab_title(4,tr("tokentakas"))
	$TabContainer.set_tab_title(6,tr("bakim"))
	$sat.visible = false
	$sat.text = tr("sat")
	$satinal.text = tr("satinal")
	$Label.text = yazilar["c5"]
	$Label.add_theme_color_override("font_color" ,Color(1,0,0,1))
	$fiyat.text = tr("fiyat")+":" + str(fiyat["c5"])
	market = 0
	if Global.kayit["tutorial"]["market"] == 0:
		var t = load("res://tscndosyalari/menu/Tutorial.tscn").instantiate()
		t.mod = "market"
		get_parent().call_deferred("add_child",t)
######################TEKERLEK
func _on_c5_pressed():
	Global.oynat("res://muzik/uisounds/clicksound.ogg")
	$Label.text = yazilar["c5"]
	$Label.add_theme_color_override("font_color" ,Color(1,0,0,1))
	$fiyat.text = tr("fiyat")+":" + str(fiyat["c5"])
	market = 0 ; Global.oynat("click")
func _on_c3_pressed():
	Global.oynat("res://muzik/uisounds/clicksound.ogg")
	$Label.text = yazilar["c3"]
	$Label.add_theme_color_override("font_color" ,Color(1,1,0,1))
	$fiyat.text = tr("fiyat")+":" + str(fiyat["c3"])
	market = 1 ; Global.oynat("click")
func _on_c1_pressed():
	Global.oynat("res://muzik/uisounds/clicksound.ogg")
	$Label.text = yazilar["c1"]
	$Label.add_theme_color_override("font_color" ,Color(1,1,1,1))
	$fiyat.text = tr("fiyat")+":" + str(fiyat["c1"])
	market = 2 ; Global.oynat("click")
func _on_eko_pressed():
	$Label.text = yazilar["konfor"]
	$Label.add_theme_color_override("font_color" ,Color(0.2,0.2,0.2,1))
	$fiyat.text = tr("fiyat")+":" + str(fiyat["konfor"])
	market = 3 ; Global.oynat("click")
########################TOKEN
func _on_elmas_pressed():
	$Label.text = yazilar["elmas"]
	$fiyat.text = yazilar["elmasfiyat"]
	$Label.add_theme_color_override("font_color",Color(0,1,1,1))
	market = 4 ; Global.oynat("click")
func _on_altin_pressed():
	$Label.text = yazilar["altin"]
	$fiyat.text = yazilar["altinfiyat"]
	$Label.add_theme_color_override("font_color",Color(1,1,0,1))
	market = 5 ; Global.oynat("click")
func _on_gumus_pressed():
	$Label.text = yazilar["gumus"]
	$fiyat.text = yazilar["gumusfiyat"]
	$Label.add_theme_color_override("font_color",Color(0.5,0.5,0.5,1))
	market = 6 ; Global.oynat("click")
func _on_bronz_pressed():
	$Label.text = yazilar["bronz"]
	$fiyat.text = yazilar["bronzfiyat"]
	$Label.add_theme_color_override("font_color",Color(0.8,0.3,0,1))
	market = 7 ; Global.oynat("click")
##########################ELMAS
func _on_1elmas_pressed():
	$Label.add_theme_color_override("font_color",Color(0,1,1,1))
	$Label.text = yazilar["1e"]
	$fiyat.text = str(fiyat["1e"]) + tr("birim")
	market = 8 ; Global.oynat("click")
func _on_2elmas_pressed():
	$Label.add_theme_color_override("font_color",Color(0,1,1,1))
	$Label.text = yazilar["2e"]
	$fiyat.text = str(fiyat["2e"]) + tr("birim")
	market = 9 ; Global.oynat("click")
func _on_5elmas_pressed():
	$Label.add_theme_color_override("font_color",Color(0,1,1,1))
	$Label.text = yazilar["6e"]
	$fiyat.text = str(fiyat["6e"]) + tr("birim")
	market = 10 ; Global.oynat("click")
func _on_10elmas_pressed():
	$Label.add_theme_color_override("font_color",Color(0,1,1,1))
	$Label.text = yazilar["12e"]
	$fiyat.text = str(fiyat["12e"]) + tr("birim")
	market = 11 ; Global.oynat("click")
#######################Diger
func _on_yag_pressed():
	$Label.text = yazilar["yag"]
	$fiyat.text = tr("fiyat")+":" + str(fiyat["yag"])
	$Label.add_theme_color_override("font_color" ,Color(0.2,0.2,0.2,1))
	market = 12 ; Global.oynat("click")
func _on_motor_pressed():
	$Label.text = yazilar["motor"]
	$fiyat.text = tr("fiyat")+":" + str(fiyat["motor"])
	$Label.add_theme_color_override("font_color" ,Color(0.2,0.2,0.2,1))
	market = 13 ; Global.oynat("click")
#######################Satin Al
func _on_satinal_pressed():
	if market == 0 and Global.kayit["para"]["para"] >= fiyat["c5"]:
		Global.kayit["basarimlar"]["b5"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["c5"]
		Global.kayit["tekerlekler"]["c5"] += 1
		Global.oyuncuseviye(50)
		get_node("ParaTablo/isim/Level").xparttir()
		yazilariguncelle()
		$Label.text = yazilar["c5"]
	elif market == 0 and Global.kayit["para"]["para"] < fiyat["c5"]:
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok_button().text = tr("tamam")
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok_button().focus_mode = Control.FOCUS_NONE
		$"TabContainer/Tekerlek Al/poptekerlek".dialog_text = parayok
		$"TabContainer/Tekerlek Al/poptekerlek".popup()
	elif market == 1 and Global.kayit["para"]["para"] >= fiyat["c3"]:
		Global.kayit["basarimlar"]["b5"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["c3"]
		Global.kayit["tekerlekler"]["c3"] += 1
		Global.oyuncuseviye(25)
		get_node("ParaTablo/isim/Level").xparttir()
		yazilariguncelle()
		$Label.text = yazilar["c3"]
	elif market == 1 and Global.kayit["para"]["para"] < fiyat["c3"]:
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok_button().text = tr("tamam")
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok_button().focus_mode = Control.FOCUS_NONE
		$"TabContainer/Tekerlek Al/poptekerlek".dialog_text = parayok
		$"TabContainer/Tekerlek Al/poptekerlek".popup()
	elif market == 2 and Global.kayit["para"]["para"] >= fiyat["c1"]:
		Global.kayit["basarimlar"]["b5"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["c1"]
		Global.kayit["tekerlekler"]["c1"] += 1
		Global.oyuncuseviye(15)
		get_node("ParaTablo/isim/Level").xparttir()
		yazilariguncelle()
		$Label.text = yazilar["c1"]
	elif market == 2 and Global.kayit["para"]["para"] < fiyat["c1"]:
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok_button().text = tr("tamam")
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok_button().focus_mode = Control.FOCUS_NONE
		$"TabContainer/Tekerlek Al/poptekerlek".dialog_text = parayok
		$"TabContainer/Tekerlek Al/poptekerlek".popup()
	elif market == 3 and Global.kayit["para"]["para"] >= fiyat["konfor"]:
		Global.kayit["basarimlar"]["b5"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["konfor"]
		Global.kayit["tekerlekler"]["konfor"] += 1
		Global.oyuncuseviye(5)
		get_node("ParaTablo/isim/Level").xparttir()
		yazilariguncelle()
		$Label.text = yazilar["konfor"]
	elif market == 3 and Global.kayit["para"]["para"] < fiyat["konfor"]:
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok_button().text = tr("tamam")
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok_button().focus_mode = Control.FOCUS_NONE
		$"TabContainer/Tekerlek Al/poptekerlek".dialog_text = parayok
		$"TabContainer/Tekerlek Al/poptekerlek".popup()
		#################################################
	elif market == 4 and Global.kayit["para"]["para"] >= fiyat["elmasal"]:
		Global.kayit["para"]["para"] -= fiyat["elmasal"]
		Global.kayit["para"]["elmas"] += 1
	elif market == 5 and Global.kayit["para"]["para"] >= fiyat["altinal"]:
		Global.kayit["para"]["para"] -= fiyat["altinal"]
		Global.kayit["para"]["altin"] += 1
	elif market == 6 and Global.kayit["para"]["para"] >= fiyat["gumusal"]:
		Global.kayit["para"]["para"] -= fiyat["gumusal"]
		Global.kayit["para"]["gumus"] += 1
	elif market == 7 and Global.kayit["para"]["para"] >= fiyat["bronzal"]:
		Global.kayit["para"]["para"] -= fiyat["bronzal"]
		Global.kayit["para"]["bronz"] += 1
		#######################################################
	elif market == 12 and Global.kayit["para"]["para"] >= fiyat["yag"] and Global.kayit["tekerlekler"]["yag"] < 90:
		Global.kayit["basarimlar"]["b6"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["yag"]
		Global.kayit["tekerlekler"]["yag"] = 100
		Global.oyuncuseviye(50)
		get_node("ParaTablo/isim/Level").xparttir()
		yazilariguncelle()
		$Label.text = yazilar["yag"]
	elif market == 12 and Global.kayit["para"]["para"] < fiyat["yag"]:
		$"TabContainer/Diğer/popdiger".get_ok_button().text = tr("tamam")
		$"TabContainer/Diğer/popdiger".dialog_text = parayok
		$"TabContainer/Diğer/popdiger".popup()
	elif market == 12 and Global.kayit["tekerlekler"]["yag"] >= 90:
		$"TabContainer/Diğer/popdiger".get_ok_button().text = tr("tamam")
		$"TabContainer/Diğer/popdiger".dialog_text = tr("yagyeni")
		$"TabContainer/Diğer/popdiger".popup()
	elif market == 13 and Global.kayit["para"]["para"] >= fiyat["motor"] and Global.kayit["tekerlekler"]["motor"] < 90:
		Global.kayit["basarimlar"]["b7"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["motor"]
		Global.kayit["tekerlekler"]["motor"] = 100
		Global.oyuncuseviye(100)
		get_node("ParaTablo/isim/Level").xparttir()
		yazilariguncelle()
		$Label.text = yazilar["motor"]
	elif market == 13 and Global.kayit["para"]["para"] < fiyat["motor"]:
		$"TabContainer/Diğer/popdiger".get_ok_button().text = tr("tamam")
		$"TabContainer/Diğer/popdiger".dialog_text = parayok
		$"TabContainer/Diğer/popdiger".popup()
	elif market == 13 and Global.kayit["tekerlekler"]["motor"] >= 90:
		$"TabContainer/Diğer/popdiger".get_ok_button().text = tr("tamam")
		$"TabContainer/Diğer/popdiger".dialog_text = tr("motoryeni")
		$"TabContainer/Diğer/popdiger".popup()
	Global.oyunkaydet()
	Global.oynat("click")
	$ParaTablo.paralabelguncelle()
	pass
#######################Satin Al
#######################Sat
func _on_sat_pressed():
	if market == 4 and Global.kayit["para"]["elmas"] >= 1:
		Global.kayit["para"]["para"] += fiyat["elmassat"]
		Global.kayit["para"]["elmas"] -= 1
		Global.oyuncuseviye(100)
		Global.oynat("res://muzik/uisounds/clicksound.ogg")
	elif market == 5 and Global.kayit["para"]["altin"] >= 1:
		Global.kayit["para"]["para"] += fiyat["altinsat"]
		Global.kayit["para"]["altin"] -= 1
		Global.oyuncuseviye(50)
		Global.oynat("res://muzik/uisounds/clicksound.ogg")
	elif market == 6 and Global.kayit["para"]["gumus"] >= 1:
		Global.kayit["para"]["para"] += fiyat["gumussat"]
		Global.kayit["para"]["gumus"] -= 1
		Global.oynat("res://muzik/uisounds/clicksound.ogg")
		Global.oyuncuseviye(20)
	elif market == 7 and Global.kayit["para"]["bronz"] >= 1:
		Global.kayit["para"]["para"] += fiyat["bronzsat"]
		Global.kayit["para"]["bronz"] -= 1
		Global.oynat("res://muzik/uisounds/clicksound.ogg")
		Global.oyuncuseviye(10)
	get_node("ParaTablo/isim/Level").xparttir()
	Global.oyunkaydet()
	$ParaTablo.paralabelguncelle()
#######################Sat
func _on_TabContainer_tab_changed(tab):
	$TabContainer.get_child(tab).get_child(0).get_child(0).get_child(0).emit_signal("pressed")
	$sat.visible = tab == 4
	Global.oynat("click")
