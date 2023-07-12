extends InterpolatedCamera
var z
func _ready():
	z = translation.z
var konum = "topcamera"
func kamera(val, hiz):
	h_offset = - val / 2
	if konum == "topcamera":
		translation.z = z - (hiz / 200)
	pass
