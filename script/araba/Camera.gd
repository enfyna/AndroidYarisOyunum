extends Camera3D
var z
func _ready():
	z = position.z
var konum = "topcamera"
func kamera(val, hiz):
	h_offset = - val / 2
	if konum == "topcamera":
		position.z = z - (hiz / 200)
	pass
