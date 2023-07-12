extends StaticBody3D
var index = AudioServer.get_bus_channels(1)
var ilk = 0 ; var rev = 0 ; var lset = 0

func _ready():
	set_process(false)

func _process(delta):
	if rev != lset: 
		if lset == 1:
			rev += delta*2
			if rev > 1:
				rev = 1
		else:
			rev -= delta*2
			if rev < 0:
				rev = 0
		AudioServer.get_bus_effect(index,0).wet = rev
	else:
		if rev == 0:
			AudioServer.set_bus_effect_enabled(index,0,false)
		set_process(false)
	
func _on_Area_body_entered(_body):
	AudioServer.set_bus_effect_enabled(index,0,true)
	if ilk == 1:
		lset = 1
	else:
		ilk += 1
	set_process(true)
func _on_Area_body_exited(_body):
	lset = 0
	set_process(true)
