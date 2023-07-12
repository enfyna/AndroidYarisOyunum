extends TextureProgressBar

"onready var araba = get_parent()\nfunc rpmbar(delta, rpm):\n	value = lerp(value,rpm,delta*5)\n	if value > 6000:\n		tint_progress = Color(randf()+0.3,0,0,1)\n	else:\n		tint_progress = Color(0,rpm/10000+0.4,1,1)\n	araba.yakilanyag -= sqrt(sqrt(rpm))/90000 #Yag yak\n	if rpm > 5000:\n		emit_signal(\"rpmcok\")\n	elif rpm < 3900:\n		emit_signal(\"rpmaz\")"


