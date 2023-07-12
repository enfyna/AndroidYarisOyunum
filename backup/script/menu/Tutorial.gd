extends Control
var yuzde = 0
var yazi : String
var ses = 0
var mod = "giris"
onready var sesnode = $ses
onready var label = $TextureRect2/Label
var yazilar 
var giris = [tr("giris1")%[Global.kayit["oyuncu"]["isim"]]
			,tr("giris2")
			,tr("giris3")
			,tr("giris4")
			,tr("giris5")
			,tr("giris6")
			,tr("giris7")
			,tr("giris8")
			,tr("giris9")
			,tr("giris10")
			,tr("giris11")
			,tr("giris12")
			,tr("giris13")
			,tr("giris14")
			,tr("giris15")
			,tr("giris16")
			,tr("giris17")
			,tr("giris18")
			,tr("giris19")
			,tr("giris20")
			,tr("giris21")
			,tr("giris22")
			,tr("giris23")
			,tr("giris24")
			]
var market =[tr("market1")
			,tr("market2")
			,tr("market3")
			,tr("market4")
			,tr("market5")
			]

var dur = {"giris":[2,4,6,7,10,24],"market":[5]}
func _ready():
	yazilar = {"giris":giris,"market":market}
	modulate = Color(1,1,1,0)
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.7)
	label.percent_visible = 0
	yaziayarla()
func _on_Button_pressed():
	if label.percent_visible > 0.5:
		yuzde = 0
		ses = 0
		if not dur[mod].has(Global.kayit["tutorial"][mod]):
			Global.kayit["tutorial"][mod] += 1
			yaziayarla()
		else:
			silanim()
func yaziayarla():
	if Global.kayit["tutorial"][mod] < yazilar[mod].size() :
		yazi = yazilar[mod][Global.kayit["tutorial"][mod]]
		label.percent_visible = 0
		label.text = "     " + yazi
		var tween = create_tween()
		tween.set_parallel(true)
		tween.connect("step_finished",self,"sescikar")
		tween.tween_property(label,"percent_visible",1.0,0.4)
		tween.tween_method(self,"sescikar",0.0,1.0,0.5)
	else:
		silanim()
func sescikar(_i = 0):
	sesnode.play()
func silanim():
	var tween = create_tween()
	tween.connect("finished",self,"sil")
	tween.tween_property(self,"modulate",Color(1,1,1,0),0.3)
func sil():
	Global.oyunkaydet()
	if get_tree().get_current_scene().name == "Yaris":
		get_node("/root/Yaris").player.tutorial = false
	call_deferred("free")
