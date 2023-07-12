extends Control
var parayok = tr("parayok")
var market = 0
var yazilar
var fiyat = {"c5":5000, 
						"c3":2000, 
						"c1":1000, 
						"konfor":500, 
						"elmasal":100000, 
						"elmassat":10000, 
						"altinal":9000, 
						"altinsat":5000, 
						"gumusal":4500, 
						"gumussat":2000, 
						"bronzal":1500, 
						"bronzsat":1000, 
						"yag":500, 
						"motor":10000, 
						"1e":1, 
						"2e":1.5, 
						"6e":3, 
						"12e":5, }
func yazilariguncelle():
	var c5yuzde = fmod(Global.kayit["tekerlekler"]["c5"], 1) if fmod(Global.kayit["tekerlekler"]["c5"], 1) != 0 or Global.kayit["tekerlekler"]["c5"] == 0 else 1.0
	var c3yuzde = fmod(Global.kayit["tekerlekler"]["c3"], 1) if fmod(Global.kayit["tekerlekler"]["c3"], 1) != 0 or Global.kayit["tekerlekler"]["c3"] == 0 else 1.0
	var c1yuzde = fmod(Global.kayit["tekerlekler"]["c1"], 1) if fmod(Global.kayit["tekerlekler"]["c1"], 1) != 0 or Global.kayit["tekerlekler"]["c1"] == 0 else 1.0
	var konforyuzde = fmod(Global.kayit["tekerlekler"]["konfor"], 1) if fmod(Global.kayit["tekerlekler"]["konfor"], 1) != 0 or Global.kayit["tekerlekler"]["konfor"] == 0 else 1.0
	yazilar = {"c5":tr("mc5") + "\n" + tr("sahipolunan") + ": " + str(max(0, c5yuzde) * 100) + "%+" + str(max(0, ceil(Global.kayit["tekerlekler"]["c5"]) - 1)) + "\n(%10/3.15)", 
						"c3":tr("mc3") + "\n" + tr("sahipolunan") + ": " + str(max(0, c3yuzde) * 100) + "%+" + str(max(0, ceil(Global.kayit["tekerlekler"]["c3"]) - 1)) + "\n(%5/2.83)", 
						"c1":tr("mc1") + "\n" + tr("sahipolunan") + ": " + str(max(0, c1yuzde) * 100) + "%+" + str(max(0, ceil(Global.kayit["tekerlekler"]["c1"]) - 1)) + "\n(%4/2.15)", 
						"konfor":tr("mkonfor") + "\n" + tr("sahipolunan") + ": " + str(max(0, konforyuzde) * 100) + "%+" + str(max(0, ceil(Global.kayit["tekerlekler"]["konfor"]) - 1)) + "\n(%2/1.53)", 
						"elmas":tr("melmas") + "\n" + tr("satinal") + ": " + str(fiyat["elmasal"]) + "\n" + tr("sat") + ": " + str(fiyat["elmassat"]), 
						"altin":tr("maltin") + "\n" + tr("satinal") + ": " + str(fiyat["altinal"]) + "\n" + tr("sat") + ": " + str(fiyat["altinsat"]), 
						"gumus":tr("mgumus") + "\n" + tr("satinal") + ": " + str(fiyat["gumusal"]) + "\n" + tr("sat") + ": " + str(fiyat["gumussat"]), 
						"bronz":tr("mbronz") + "\n" + tr("satinal") + ": " + str(fiyat["bronzal"]) + "\n" + tr("sat") + ": " + str(fiyat["bronzsat"]), 
						"yag":tr("myag") + "\n\n" + tr("durum") + " : %" + str(int(Global.kayit["tekerlekler"]["yag"])), 
						"motor":tr("mmotor") + "\n\n" + tr("durum") + " : %" + str(int(Global.kayit["tekerlekler"]["motor"])), 
						"1e":"1 " + tr("melmas"), 
						"2e":"2 " + tr("melmas"), 
						"6e":"5+1 " + tr("melmas"), 
						"12e":"10+2 " + tr("melmas"), }
func _ready():
	yazilariguncelle()
	$TabContainer.set_tab_disabled(1, true)
	$TabContainer.set_tab_disabled(3, true)
	$TabContainer.set_tab_disabled(5, true)
	$TabContainer.set_tab_title(0, tr("tekeral"))
	$TabContainer.set_tab_title(2, tr("elmasal"))
	$TabContainer.set_tab_title(4, tr("tokentakas"))
	$TabContainer.set_tab_title(6, tr("bakim"))
	$"TabContainer/Diğer/satinaldiger".text = tr("satinal")
	$"TabContainer/Token Takas Et/tokenal".text = tr("satinal")
	$"TabContainer/Token Takas Et/tokensat".text = tr("sat")
	$"TabContainer/Elmas Al/elmassatinal".text = tr("satinal")
	$"TabContainer/Tekerlek Al/satinal".text = tr("satinal")
	$"TabContainer/Tekerlek Al/Label".text = yazilar["c5"]
	$"TabContainer/Tekerlek Al/fiyat".text = tr("fiyat") + ":" + str(fiyat["c5"])
	$"TabContainer/Diğer/Label".text = yazilar["yag"]
	$"TabContainer/Diğer/fiyat".text = tr("fiyat") + ":" + str(fiyat["yag"])
	$"TabContainer/Token Takas Et/Label".text = yazilar["elmas"]
	$"TabContainer/Elmas Al/Label".text = yazilar["1e"]
	$"TabContainer/Elmas Al/fiyat".text = str(fiyat["1e"]) + " " + tr("birim")
	market = 0
	pass

func _on_c5_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	$"TabContainer/Tekerlek Al/Label".text = yazilar["c5"]
	$"TabContainer/Tekerlek Al/Label".add_color_override("font_color", Color(1, 0, 0, 1))
	$"TabContainer/Tekerlek Al/fiyat".text = tr("fiyat") + ":" + str(fiyat["c5"])
	market = 0
	pass
func _on_c3_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	$"TabContainer/Tekerlek Al/Label".text = yazilar["c3"]
	$"TabContainer/Tekerlek Al/Label".add_color_override("font_color", Color(1, 1, 0, 1))
	$"TabContainer/Tekerlek Al/fiyat".text = tr("fiyat") + ":" + str(fiyat["c3"])
	market = 1
	pass
func _on_c1_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	$"TabContainer/Tekerlek Al/Label".text = yazilar["c1"]
	$"TabContainer/Tekerlek Al/Label".add_color_override("font_color", Color(1, 1, 1, 1))
	$"TabContainer/Tekerlek Al/fiyat".text = tr("fiyat") + ":" + str(fiyat["c1"])
	market = 2
	pass
func _on_eko_pressed():
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	$"TabContainer/Tekerlek Al/Label".text = yazilar["konfor"]
	$"TabContainer/Tekerlek Al/Label".add_color_override("font_color", Color(0, 0, 0, 1))
	$"TabContainer/Tekerlek Al/fiyat".text = tr("fiyat") + ":" + str(fiyat["konfor"])
	market = 3
	pass
func _on_satinal_pressed():
	if market == 0 and Global.kayit["para"]["para"] >= fiyat["c5"]:
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
		Global.kayit["basarimlar"]["b5"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["c5"]
		Global.kayit["tekerlekler"]["c5"] += 1
		Global.oyuncuseviye(50)
		get_node("ParaTablo/isim/Level").xparttir()
		yazilariguncelle()
		$"TabContainer/Tekerlek Al/Label".text = yazilar["c5"]
	elif market == 0 and Global.kayit["para"]["para"] < fiyat["c5"]:
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok().text = tr("tamam")
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok().focus_mode = Control.FOCUS_NONE
		$"TabContainer/Tekerlek Al/poptekerlek".dialog_text = parayok
		$"TabContainer/Tekerlek Al/poptekerlek".popup()
	elif market == 1 and Global.kayit["para"]["para"] >= fiyat["c3"]:
		Global.kayit["basarimlar"]["b5"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["c3"]
		Global.kayit["tekerlekler"]["c3"] += 1
		Global.oyuncuseviye(25)
		get_node("ParaTablo/isim/Level").xparttir()
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
		yazilariguncelle()
		$"TabContainer/Tekerlek Al/Label".text = yazilar["c3"]
	elif market == 1 and Global.kayit["para"]["para"] < fiyat["c3"]:
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok().text = tr("tamam")
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok().focus_mode = Control.FOCUS_NONE
		$"TabContainer/Tekerlek Al/poptekerlek".dialog_text = parayok
		$"TabContainer/Tekerlek Al/poptekerlek".popup()
	elif market == 2 and Global.kayit["para"]["para"] >= fiyat["c1"]:
		Global.kayit["basarimlar"]["b5"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["c1"]
		Global.kayit["tekerlekler"]["c1"] += 1
		Global.oyuncuseviye(15)
		get_node("ParaTablo/isim/Level").xparttir()
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
		yazilariguncelle()
		$"TabContainer/Tekerlek Al/Label".text = yazilar["c1"]
	elif market == 2 and Global.kayit["para"]["para"] < fiyat["c1"]:
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok().text = tr("tamam")
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok().focus_mode = Control.FOCUS_NONE
		$"TabContainer/Tekerlek Al/poptekerlek".dialog_text = parayok
		$"TabContainer/Tekerlek Al/poptekerlek".popup()
	elif market == 3 and Global.kayit["para"]["para"] >= fiyat["konfor"]:
		Global.kayit["basarimlar"]["b5"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["konfor"]
		Global.kayit["tekerlekler"]["konfor"] += 1
		Global.oyuncuseviye(5)
		get_node("ParaTablo/isim/Level").xparttir()
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
		yazilariguncelle()
		$"TabContainer/Tekerlek Al/Label".text = yazilar["konfor"]
	elif market == 3 and Global.kayit["para"]["para"] < fiyat["konfor"]:
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok().text = tr("tamam")
		$"TabContainer/Tekerlek Al/poptekerlek".get_ok().focus_mode = Control.FOCUS_NONE
		$"TabContainer/Tekerlek Al/poptekerlek".dialog_text = parayok
		$"TabContainer/Tekerlek Al/poptekerlek".popup()
	Global.oyunkaydet()
	$ParaTablo.paralabelguncelle()
	pass

func _on_elmas_pressed():
	$"TabContainer/Token Takas Et/Label".text = yazilar["elmas"]
	$"TabContainer/Token Takas Et/Label".add_color_override("font_color", Color(0, 1, 1, 1))
	market = 4
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass
func _on_altin_pressed():
	$"TabContainer/Token Takas Et/Label".text = yazilar["altin"]
	$"TabContainer/Token Takas Et/Label".add_color_override("font_color", Color(1, 1, 0, 1))
	market = 5
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass
func _on_gumus_pressed():
	$"TabContainer/Token Takas Et/Label".text = yazilar["gumus"]
	$"TabContainer/Token Takas Et/Label".add_color_override("font_color", Color(0.5, 0.5, 0.5, 1))
	market = 6
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass
func _on_bronz_pressed():
	$"TabContainer/Token Takas Et/Label".text = yazilar["bronz"]
	$"TabContainer/Token Takas Et/Label".add_color_override("font_color", Color(0.8, 0.3, 0, 1))
	market = 7
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass

func _on_1elmas_pressed():
	$"TabContainer/Elmas Al/Label".text = yazilar["1e"]
	$"TabContainer/Elmas Al/fiyat".text = str(fiyat["1e"]) + tr("birim")
	market = 8
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass
func _on_2elmas_pressed():
	$"TabContainer/Elmas Al/Label".text = yazilar["2e"]
	$"TabContainer/Elmas Al/fiyat".text = str(fiyat["2e"]) + tr("birim")
	market = 9
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass
func _on_5elmas_pressed():
	$"TabContainer/Elmas Al/Label".text = yazilar["6e"]
	$"TabContainer/Elmas Al/fiyat".text = str(fiyat["6e"]) + tr("birim")
	market = 10
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass
func _on_10elmas_pressed():
	$"TabContainer/Elmas Al/Label".text = yazilar["12e"]
	$"TabContainer/Elmas Al/fiyat".text = str(fiyat["12e"]) + tr("birim")
	market = 11
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass

func _on_yag_pressed():
	$"TabContainer/Diğer/Label".text = yazilar["yag"]
	$"TabContainer/Diğer/fiyat".text = tr("fiyat") + ":" + str(fiyat["yag"])
	market = 12
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass
func _on_motor_pressed():
	$"TabContainer/Diğer/Label".text = yazilar["motor"]
	$"TabContainer/Diğer/fiyat".text = tr("fiyat") + ":" + str(fiyat["motor"])
	market = 13
	AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	pass

func _on_satinaldiger_pressed():
	if market == 12 and Global.kayit["para"]["para"] >= fiyat["yag"] and Global.kayit["tekerlekler"]["yag"] < 90:
		Global.kayit["basarimlar"]["b6"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["yag"]
		Global.kayit["tekerlekler"]["yag"] = 100
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
		Global.oyuncuseviye(50)
		get_node("ParaTablo/isim/Level").xparttir()
		yazilariguncelle()
		$"TabContainer/Diğer/Label".text = yazilar["yag"]
	elif market == 12 and Global.kayit["para"]["para"] < fiyat["yag"]:
		$"TabContainer/Diğer/popdiger".get_ok().text = tr("tamam")
		$"TabContainer/Diğer/popdiger".dialog_text = parayok
		$"TabContainer/Diğer/popdiger".popup()
	elif market == 12 and Global.kayit["tekerlekler"]["yag"] >= 90:
		$"TabContainer/Diğer/popdiger".get_ok().text = tr("tamam")
		$"TabContainer/Diğer/popdiger".dialog_text = tr("yagyeni")
		$"TabContainer/Diğer/popdiger".popup()
	elif market == 13 and Global.kayit["para"]["para"] >= fiyat["motor"] and Global.kayit["tekerlekler"]["motor"] < 90:
		Global.kayit["basarimlar"]["b7"]["ilerleme"] += 1
		Global.kayit["para"]["para"] -= fiyat["motor"]
		Global.kayit["tekerlekler"]["motor"] = 100
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
		Global.oyuncuseviye(100)
		get_node("ParaTablo/isim/Level").xparttir()
		yazilariguncelle()
		$"TabContainer/Diğer/Label".text = yazilar["motor"]
	elif market == 13 and Global.kayit["para"]["para"] < fiyat["motor"]:
		$"TabContainer/Diğer/popdiger".get_ok().text = tr("tamam")
		$"TabContainer/Diğer/popdiger".dialog_text = parayok
		$"TabContainer/Diğer/popdiger".popup()
	elif market == 13 and Global.kayit["tekerlekler"]["motor"] >= 90:
		$"TabContainer/Diğer/popdiger".get_ok().text = tr("tamam")
		$"TabContainer/Diğer/popdiger".dialog_text = tr("motoryeni")
		$"TabContainer/Diğer/popdiger".popup()
	Global.oyunkaydet()
	$ParaTablo.paralabelguncelle()
	pass



func _on_tokensat_pressed():
	if market == 4 and Global.kayit["para"]["elmas"] >= 1:
		Global.kayit["para"]["para"] += fiyat["elmassat"]
		Global.kayit["para"]["elmas"] -= 1
		Global.oyuncuseviye(100)
		get_node("ParaTablo/isim/Level").xparttir()
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	elif market == 5 and Global.kayit["para"]["altin"] >= 1:
		Global.kayit["para"]["para"] += fiyat["altinsat"]
		Global.kayit["para"]["altin"] -= 1
		Global.oyuncuseviye(50)
		get_node("ParaTablo/isim/Level").xparttir()
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	elif market == 6 and Global.kayit["para"]["gumus"] >= 1:
		Global.kayit["para"]["para"] += fiyat["gumussat"]
		Global.kayit["para"]["gumus"] -= 1
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
		Global.oyuncuseviye(20)
		get_node("ParaTablo/isim/Level").xparttir()
	elif market == 7 and Global.kayit["para"]["bronz"] >= 1:
		Global.kayit["para"]["para"] += fiyat["bronzsat"]
		Global.kayit["para"]["bronz"] -= 1
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
		Global.oyuncuseviye(10)
		get_node("ParaTablo/isim/Level").xparttir()
	Global.oyunkaydet()
	$ParaTablo.paralabelguncelle()
	pass
func _on_tokenal_pressed():
	if market == 4 and Global.kayit["para"]["para"] >= fiyat["elmasal"]:
		Global.kayit["para"]["para"] -= fiyat["elmasal"]
		Global.kayit["para"]["elmas"] += 1
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	elif market == 5 and Global.kayit["para"]["para"] >= fiyat["altinal"]:
		Global.kayit["para"]["para"] -= fiyat["altinal"]
		Global.kayit["para"]["altin"] += 1
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	elif market == 6 and Global.kayit["para"]["para"] >= fiyat["gumusal"]:
		Global.kayit["para"]["para"] -= fiyat["gumusal"]
		Global.kayit["para"]["gumus"] += 1
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	elif market == 7 and Global.kayit["para"]["para"] >= fiyat["bronzal"]:
		Global.kayit["para"]["para"] -= fiyat["bronzal"]
		Global.kayit["para"]["bronz"] += 1
		AudioManager.play("res://muzik/uisounds/clicksound.ogg")
	Global.oyunkaydet()
	$ParaTablo.paralabelguncelle()
	pass

