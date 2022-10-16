extends Control


func _ready():
	if Global.kayit["basarimlar"]["b1"]["ilerleme"] < 100:
		$S/V/B1/H/Sag/Label.text = tr("b1")
		$S/V/B1/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b1"]["ilerleme"]
		$S/V/B1/H/Sag/ProgressBar.max_value = 100
	elif Global.kayit["basarimlar"]["b1"]["ilerleme"] < 500:
		$S/V/B1/H/Sag/Label.text = tr("b2")
		$S/V/B1/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b1"]["ilerleme"]
		$S/V/B1/H/Sag/ProgressBar.max_value = 500
	elif Global.kayit["basarimlar"]["b1"]["ilerleme"] < 1000:
		$S/V/B1/H/Sag/Label.text = tr("b3")
		$S/V/B1/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b1"]["ilerleme"]
		$S/V/B1/H/Sag/ProgressBar.max_value = 1000
		
	if Global.kayit["basarimlar"]["b4"]["ilerleme"] == 0:
		$S/V/B2/H/Sag/Label.text = tr("b19")
		$S/V/B2/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b4"]["ilerleme"]
		$S/V/B2/H/Sag/ProgressBar.max_value = 1
	elif Global.kayit["basarimlar"]["b4"]["ilerleme"] == 1:
		$S/V/B2/H/Sag/Label.text = tr("b20")
		$S/V/B2/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b4"]["ilerleme"]
		$S/V/B2/H/Sag/ProgressBar.max_value = 2
	elif Global.kayit["basarimlar"]["b4"]["ilerleme"] == 2:
		$S/V/B2/H/Sag/Label.text = tr("b21")
		$S/V/B2/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b4"]["ilerleme"]
		$S/V/B2/H/Sag/ProgressBar.max_value = 3
		
	if Global.kayit["basarimlar"]["b3"]["ilerleme"] == 0:
		$S/V/B3/H/Sag/Label.text = tr("b4")
		$S/V/B3/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b3"]["ilerleme"]
		$S/V/B3/H/Sag/ProgressBar.max_value = 1
	elif Global.kayit["basarimlar"]["b3"]["ilerleme"]== 1:
		$S/V/B3/H/Sag/Label.text = tr("b5")
		$S/V/B3/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b3"]["ilerleme"]
		$S/V/B3/H/Sag/ProgressBar.max_value = 2
	elif Global.kayit["basarimlar"]["b3"]["ilerleme"] == 2:
		$S/V/B3/H/Sag/Label.text = tr("b6")
		$S/V/B3/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b3"]["ilerleme"]
		$S/V/B3/H/Sag/ProgressBar.max_value = 3
		
	if Global.kayit["tarih"]["toplamoynamasure"] < 3600:
		Global.kayit["basarimlar"]["b2"] = 0
		$S/V/B4/H/Sag/Label.text = tr("b7")
		$S/V/B4/H/Sag/ProgressBar.value = Global.kayit["tarih"]["toplamoynamasure"]
		$S/V/B4/H/Sag/ProgressBar.max_value = 36000
	elif Global.kayit["tarih"]["toplamoynamasure"] < 36000:
		Global.kayit["basarimlar"]["b2"] = 1
		$S/V/B4/H/Sag/Label.text = tr("b8")
		$S/V/B4/H/Sag/ProgressBar.value = Global.kayit["tarih"]["toplamoynamasure"]
		$S/V/B4/H/Sag/ProgressBar.max_value = 36000
	elif Global.kayit["tarih"]["toplamoynamasure"] < 360000 or true:
		Global.kayit["basarimlar"]["b2"] = 2
		$S/V/B4/H/Sag/Label.text = tr("b9")
		$S/V/B4/H/Sag/ProgressBar.value = Global.kayit["tarih"]["toplamoynamasure"]
		$S/V/B4/H/Sag/ProgressBar.max_value = 360000
	
	if Global.kayit["basarimlar"]["b5"]["ilerleme"] < 10:
		$S/V/B5/H/Sag/Label.text = tr("b10")
		$S/V/B5/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b5"]["ilerleme"]
		$S/V/B5/H/Sag/ProgressBar.max_value = 10
	elif Global.kayit["basarimlar"]["b5"]["ilerleme"] < 50:
		$S/V/B5/H/Sag/Label.text = tr("b11")
		$S/V/B5/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b5"]["ilerleme"]
		$S/V/B5/H/Sag/ProgressBar.max_value = 50
	elif Global.kayit["basarimlar"]["b5"]["ilerleme"] < 100:
		$S/V/B5/H/Sag/Label.text = tr("b12")
		$S/V/B5/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b5"]["ilerleme"]
		$S/V/B5/H/Sag/ProgressBar.max_value = 100
		
	if Global.kayit["basarimlar"]["b6"]["ilerleme"] < 10:
		$S/V/B6/H/Sag/Label.text = tr("b13")
		$S/V/B6/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b6"]["ilerleme"]
		$S/V/B6/H/Sag/ProgressBar.max_value = 10
	elif Global.kayit["basarimlar"]["b6"]["ilerleme"] < 50:
		$S/V/B6/H/Sag/Label.text = tr("b14")
		$S/V/B6/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b6"]["ilerleme"]
		$S/V/B6/H/Sag/ProgressBar.max_value = 50
	elif Global.kayit["basarimlar"]["b6"]["ilerleme"] < 100:
		$S/V/B6/H/Sag/Label.text = tr("b15")
		$S/V/B6/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b6"]["ilerleme"]
		$S/V/B6/H/Sag/ProgressBar.max_value = 100
	
	if Global.kayit["basarimlar"]["b7"]["ilerleme"]< 1:
		$S/V/B7/H/Sag/Label.text = tr("b16")
		$S/V/B7/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b7"]["ilerleme"]
		$S/V/B7/H/Sag/ProgressBar.max_value = 1
	elif Global.kayit["basarimlar"]["b7"]["ilerleme"] < 3:
		$S/V/B7/H/Sag/Label.text = tr("b17")
		$S/V/B7/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b7"]["ilerleme"]
		$S/V/B7/H/Sag/ProgressBar.max_value = 3
	elif Global.kayit["basarimlar"]["b7"]["ilerleme"] < 10:
		$S/V/B7/H/Sag/Label.text = tr("b18")
		$S/V/B7/H/Sag/ProgressBar.value = Global.kayit["basarimlar"]["b7"]["ilerleme"]
		$S/V/B7/H/Sag/ProgressBar.max_value = 10

