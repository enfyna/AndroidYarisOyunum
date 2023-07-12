extends ProgressBar
var girissecenegi = not Global.kayit["ayarlar"]["input"]
var hassasiyet = float(Global.kayit["ayarlar"]["hassasiyet"]) if girissecenegi else float(Global.kayit["ayarlar"]["hassasiyet"] / 5.0)
var steerlerp = 0
var steer_val = 0
var mss
var msar
var ssar
onready var parent = get_parent()
onready var kamera = get_parent().get_node("Camera")

func steervaluehesapla(speed):
	if girissecenegi:
		steerlerp = max( - 1, min(1, - 1 * Input.get_accelerometer().normalized().x * hassasiyet))
	else :
		if Input.is_action_pressed("ui_left"):
			steerlerp = 1.0
		elif Input.is_action_pressed("ui_right"):
			steerlerp = - 1.0
		else :
			steerlerp = 0.0
	steer_val = lerp(steer_val, steerlerp, hassasiyet)
	kamera.kamera(steer_val, speed)
	value = steer_val * - 1
	var steer_speed_factor = clamp(speed / mss, 0.0, 1.0)
	parent.steer_angle = steer_val * lerp(msar, ssar, steer_speed_factor)
