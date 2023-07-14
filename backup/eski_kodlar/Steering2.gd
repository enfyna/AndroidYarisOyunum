extends ProgressBar

func _process(_delta):
	value = Input.get_accelerometer().normalized().x
