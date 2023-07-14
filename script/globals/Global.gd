extends Control

var Save : SaveManager = SaveManager.new()
var Audio : AudioManager 

func _ready():
	Audio = AudioManager.new()
	add_child(Audio)
	
	if OS.get_locale_language() == "tr":
		TranslationServer.set_locale("tr")
	else:
		TranslationServer.set_locale("en")
