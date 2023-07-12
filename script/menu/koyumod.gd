extends TextureRect
func _ready():
	koyu(bool( Global.Save.get_save()["ayarlar"]["koyu"]))
func koyu(t):
	if not t:
		texture = load("res://resimler/arkaplan/anamenuarka7.png")
	else :
		texture = load("res://resimler/arkaplan/anamenuarka7dark.png")
