extends StaticBody3D


func _ready():
	
	if Global.ayarlar[4] == 1:
		$agacswitch.visible = 1
	else:
		$agacswitch.visible = 0
	
	pass
