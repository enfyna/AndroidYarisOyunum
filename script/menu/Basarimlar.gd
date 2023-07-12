extends Control


func _ready():
	return
	# var kayit : Dictionary = Global.Save.get_save()
	# var node : Node = get_node("S/V/B1/H/Sag")
	# if kayit["basarimlar"]["b1"]["ilerleme"] < 100:
	# 	node.get_node("Label").text = tr("b1")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b1"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 100
	# elif kayit["basarimlar"]["b1"]["ilerleme"] < 500:
	# 	node.get_node("Label").text = tr("b2")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b1"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 500
	# elif kayit["basarimlar"]["b1"]["ilerleme"] < 1000:
	# 	node.get_node("Label").text = tr("b3")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b1"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 1000
	
	# node = get_node("S/V/B2/H/Sag")
	# if kayit["basarimlar"]["b4"]["ilerleme"] == 0:
	# 	node.get_node("Label").text = tr("b19")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b4"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 1
	# elif kayit["basarimlar"]["b4"]["ilerleme"] == 1:
	# 	node.get_node("Label").text = tr("b20")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b4"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 2
	# elif kayit["basarimlar"]["b4"]["ilerleme"] == 2:
	# 	node.get_node("Label").text = tr("b21")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b4"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 3
	
	# node = get_node("S/V/B3/H/Sag")
	# if kayit["basarimlar"]["b3"]["ilerleme"] == 0:
	# 	node.get_node("Label").text = tr("b4")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b3"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 1
	# elif kayit["basarimlar"]["b3"]["ilerleme"] == 1:
	# 	node.get_node("Label").text = tr("b5")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b3"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 2
	# elif kayit["basarimlar"]["b3"]["ilerleme"] == 2:
	# 	node.get_node("Label").text = tr("b6")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b3"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 3
	
	# node = get_node("S/V/B4/H/Sag")
	# if kayit["tarih"]["toplamoynamasure"] < 3600000:
	# 	kayit["basarimlar"]["b2"] = 0
	# 	node.get_node("Label").text = tr("b7")
	# 	node.get("ProgressBar").value = kayit["tarih"]["toplamoynamasure"]
	# 	node.get("ProgressBar").max_value = 3600000
	# elif kayit["tarih"]["toplamoynamasure"] < 36000000:
	# 	kayit["basarimlar"]["b2"] = 1
	# 	node.get_node("Label").text = tr("b8")
	# 	node.get("ProgressBar").value = kayit["tarih"]["toplamoynamasure"]
	# 	node.get("ProgressBar").max_value = 36000000
	# elif kayit["tarih"]["toplamoynamasure"] < 360000000:
	# 	kayit["basarimlar"]["b2"] = 2
	# 	node.get_node("Label").text = tr("b9")
	# 	node.get("ProgressBar").value = kayit["tarih"]["toplamoynamasure"]
	# 	node.get("ProgressBar").max_value = 360000000
	
	# node = get_node("S/V/B5/H/Sag")
	# if kayit["basarimlar"]["b5"]["ilerleme"] < 10:
	# 	node.get_node("Label").text = tr("b10")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b5"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 10
	# elif kayit["basarimlar"]["b5"]["ilerleme"] < 50:
	# 	node.get_node("Label").text = tr("b11")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b5"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 50
	# elif kayit["basarimlar"]["b5"]["ilerleme"] < 100:
	# 	node.get_node("Label").text = tr("b12")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b5"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 100
		
	# node = get_node("S/V/B6/H/Sag")
	# if kayit["basarimlar"]["b6"]["ilerleme"] < 10:
	# 	node.get_node("Label").text = tr("b13")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b6"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 10
	# elif kayit["basarimlar"]["b6"]["ilerleme"] < 50:
	# 	node.get_node("Label").text = tr("b14")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b6"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 50
	# elif kayit["basarimlar"]["b6"]["ilerleme"] < 100:
	# 	node.get_node("Label").text = tr("b15")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b6"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 100

	# node = get_node("S/V/B7/H/Sag")
	# if kayit["basarimlar"]["b7"]["ilerleme"] < 1:
	# 	node.get_node("Label").text = tr("b16")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b7"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 1
	# elif kayit["basarimlar"]["b7"]["ilerleme"] < 3:
	# 	node.get_node("Label").text = tr("b17")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b7"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 3
	# elif kayit["basarimlar"]["b7"]["ilerleme"] < 10:
	# 	node.get_node("Label").text = tr("b18")
	# 	node.get("ProgressBar").value = kayit["basarimlar"]["b7"]["ilerleme"]
	# 	node.get("ProgressBar").max_value = 10
