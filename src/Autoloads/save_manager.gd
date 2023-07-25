class_name SaveManager

var save_path : String = "user://enf.yna"
var loaded : bool = false
var save : Dictionary = {
	"player":{
		"name":"",
		"car":"res://tscndosyalari/araba/AE86.tscn", 
		"lvl":0, 
		"xp":0, 
	},
	"wallet":{
		"coin":5,
		"bronze":4,
		"silver":3,
		"gold":2,
		"diamond":1,
	}
}

func get_save() -> Dictionary:
	if loaded:
		return self.save
	load_save()
	return self.save

func save_game() -> void:
	var json : String = JSON.stringify(save,"\t")
	var file : FileAccess = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(json)
	print_debug("Game saved.")#Save data : "+str(json))

func load_save() -> void:
	# If no save file create new one
	if not FileAccess.file_exists(save_path):
		var file : FileAccess = FileAccess.open(save_path, FileAccess.WRITE)
		var json : String = JSON.stringify(save,"\t")
		file.store_string(json)
		print_debug("Created new save file.")#Save data : "+str(json))
		return
	# Save file found
	var file : FileAccess = FileAccess.open(save_path, FileAccess.READ)
	var json : String = file.get_as_text()
	var data : Dictionary = JSON.parse_string(json)
	merge_dict_recursive(save,data)
	loaded = true
	print_debug("Game loaded.")
	return

func merge_dict_recursive(dest_dict: Dictionary, src_dict: Dictionary) -> void:
	for key in src_dict.keys():
		if dest_dict.has(key) and dest_dict[key] is Dictionary and src_dict[key] is Dictionary:
			merge_dict_recursive(dest_dict[key], src_dict[key])
		else:
			dest_dict[key] = src_dict[key]
