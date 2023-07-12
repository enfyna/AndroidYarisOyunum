extends StaticBody

var index = AudioServer.get_bus_channels(1)
var ilk = 0
var rev = 0
var lset = 0
func _ready():
	AudioServer.set_bus_effect_enabled(index, 0, true)
	AudioServer.get_bus_effect(index, 0).wet = 0
	pass

func _process(delta):
	if rev != lset:
		rev = lerp(rev, lset, delta * 3)
		AudioServer.get_bus_effect(index, 0).wet = rev
	pass
	
func _on_Area_body_entered(_body):
	if ilk == 1:
		lset = 1
	else :
		ilk += 1
	
	pass


func _on_Area_body_exited(_body):
	lset = 0
	
	pass
