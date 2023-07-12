class_name SaveManager

var save_path : String = "user://enf.yna"
var loaded : bool = false
var save : Dictionary = {
	"para":{
		"para":0, 
		"bronz":100, 
		"gumus":100, 
		"altin":100, 
		"elmas":100
	}, 
	"pistler":{
		"Pist00":0, 
		"Pist01":0, 
		"Pist02":0, 
		"Pist03":0, 
		"Pist04":0, 
		"Pist05":0, 
		"Pist06":0, 
		"Pist07":0, 
		"Pist08":0, 
		"Pist09":0, 
		"Pist10":0, 
		"Pist11":0, 
		"Pist12":0, 
	}, 
	"pistsure":{
		"PistTest01":0,
		"Pist01":0,
		"Pist02":0,
		"Pist03":0,
		"Pist04":0,
		"Pist05":0, 
		"Pist06":0, 
		"Pist07":0, 
		"Pist08":0,
		"Pist09":0,
		"Pist00":0,
		"Pist10":0,
		"Pist11":0,
		"Pist12":0, 
	}, 
	"arabalar":{
		"ae86":{
			"sahiplik":false
		}, 
		"tico":{
			"sahiplik":false
			}
	}, 
	"tekerlekler":{
		"c5":1, 
		"c3":1, 
		"c1":1, 
		"konfor":1, 
		"yag":100, 
		"motor":100
	}, 
	"ayarlar":{
		"oto":0, 
		"hassasiyet":1, 
		"sis":0, 
		"input":0, 
		"muzik":1, 
		"koyu":0, 
		"kmh":0
	}, 
	"tutorial":{
		"giris":0
	}, 
	"basarimlar":{
		"b1":{"ilerleme":0, "odul":false}, 
		"b2":{"ilerleme":0, "odul":false}, 
		"b3":{"ilerleme":0, "odul":false},
		"b4":{"ilerleme":0, "odul":false},
		"b5":{"ilerleme":0, "odul":false},
		"b6":{"ilerleme":0, "odul":false},
		"b7":{"ilerleme":0, "odul":false},
		"b8":{"ilerleme":0, "odul":false},
		"b9":{"ilerleme":0, "odul":false},
		"b10":{"ilerleme":0, "odul":false}
	}, 
	"tarih":{
		"tarih":Time.get_datetime_dict_from_system(), 
		"toplamoynamasure":0, 
		"secilengorev":{"1":1, "2":2, "3":3, "4":false, "5":false}
	}, 
	"oyuncu":{
		"lvl":0, 
		"xp":0, 
		"seciliaraba":"", 
		"isim":""
	}, 
	"gorev":{
		"1":{"odul":10000, "hedef":1, "tamam":false, "yap":0}, 
		"2":{"odul":1000, "hedef":10, "tamam":false, "yap":0}, 
		"3":{"odul":1000, "hedef":2, "tamam":false, "yap":0}, 
		"4":{"odul":10000, "hedef":5, "tamam":false, "yap":0}, 
		"5":{"odul":5000, "hedef":2, "tamam":false, "yap":0}, 
		"6":{"odul":2000, "hedef":2, "tamam":false, "yap":0}, 
		"7":{"odul":1000, "hedef":2, "tamam":false, "yap":0}, 
		"8":{"odul":10000, "hedef":5, "tamam":false, "yap":0}, 
		"9":{"odul":1000, "hedef":5, "tamam":false, "yap":0}, 
		"10":{"odul":10000, "hedef":15, "tamam":false, "yap":0}, 
	},
}

func get_save() -> Dictionary:
	if loaded:
		return self.save
	load_save()
	return self.save

func save_game() -> void:
	var json : String = JSON.stringify(save,"\t")
	var file : FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.WRITE,"pass")
	file.store_string(json)
	print_debug("Game saved.")#Save data : "+str(json))

func load_save() -> void:
	# If no save file create new one
	if not FileAccess.file_exists(save_path):
		var file : FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.WRITE,"pass")
		var json : String = JSON.stringify(save,"\t")
		file.store_string(json)
		print_debug("Created new save file.")#Save data : "+str(json))
		return
	# Save file found
	var file : FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.READ,"pass")
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