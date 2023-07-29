class_name SaveManager

const save_path : String = "user://enf.yna"
var save_loaded : bool = false
var save : Dictionary = {
	"player":{
		"name":"",
		"car":"AE86",
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
	if save_loaded:
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
		save_loaded = true
		print_debug("Created new save file.")#Save data : "+str(json))
		return
	# Save file found
	var file : FileAccess = FileAccess.open(save_path, FileAccess.READ)
	var json : String = file.get_as_text()
	var data : Dictionary = JSON.parse_string(json)
	merge_dict_recursive(save,data)
	save_loaded = true
	print_debug("Game loaded.")
	return

func merge_dict_recursive(dest_dict: Dictionary, src_dict: Dictionary) -> void:
	for key in src_dict.keys():
		if dest_dict.has(key) and dest_dict[key] is Dictionary and src_dict[key] is Dictionary:
			merge_dict_recursive(dest_dict[key], src_dict[key])
		else:
			dest_dict[key] = src_dict[key]

const config_path : String = "user://settings.ini"
var config_loaded : bool = false
var config : ConfigFile

func get_config() -> ConfigFile:
	if config_loaded:
		return self.config
	load_config()
	return self.config

func load_config() -> void:
	config = ConfigFile.new()
	var err = config.load(config_path)
	if err == OK:
		config_loaded = true
		return
	# no config file found create new one
	const default_config : Dictionary = {
		"car":{
			"kmh":true,
			"manual":true,
			"steering_sensivity":0.5,
			"analog":true,
		},
		"general":{
			"dark_mode":true,
			"music":false,
			"music_volume":0.5,
		},
		"rendering":{
			"shadows":true,
		},
	}
	for section in default_config.keys():
		for value in default_config[section].keys():
			config.set_value(section, value, default_config[section][value])
	config.save(config_path)
	config_loaded = true
	return

func save_config(config_file : ConfigFile) -> void:
	config_file.save(config_path)
	return