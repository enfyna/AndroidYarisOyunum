extends Control

@onready var label : Label = get_node("TextureRect2/Label")

var tutoset : int = -1
var yuzde : float = 0
var yazi : String
var ses : int = 0
var fade : float = 0
var dur : Array[int] = [2, 4, 6, 8, 11, 23]

var yaziliste : Array[String] = [
	"Tanıştığıma memnun oldum %s. Oyunumu indirmene sevindim." % [Global.Save.get_save()["oyuncu"]["isim"]]
	, "Bu arada benim adım Ramazan.Sana burada işlerin nasıl yürüdüğünü gösterecegim."
	, "Sana ilk önce bir araba almamız gerekecek.Sağ üstten galeriye gidip hemen bir tane alabiliriz."
	, "Araba galerisine hoşgeldin.Buradan istediğin arabaları alabilirsin."
	, "Tabii yeterli paran varsa. ;) "
	, "Güzel seçim.Artık araba nasıl alınır biliyorsun."
	, "Arabanı aldığına göre test sürüşüne çıkmaya ne dersin ? "
	, "Test sürüşüne çıkabilmek ya da yeni pistler satın almak için Dünya ikonuna tıklaman gerekli."
	, "..."
	, "Burada sağ taraftan parayla yeni pistler satın alabilirsin."
	, "Sol taraftan oval bir pistte bedava test sürüşü yapabilirsin.Ama az para kazanırsın.Daha fazla para kazanmak için satın aldığın pistlerde oynaman gerekli."
	, "Şimdilik yeni bir pist alacak paran olmadığından oval pistte biraz para kazanmaya çalış."
	, "Evet piste çıktığımıza göre arabamızı kullanabiliriz."
	, "Ama ilk önce seni uyarmam gereken bazı şeyler var ..."
	, "Gerçek hayatta da olduğu gibi arabanı kullandıkça motor yağın eskir ya da duvarlara çarparsan motorun hasar alır."
	, "Motorun yeterince hasar alır ya da yağın çok eskirse motor performansın düşer."
	, "Bu yüzden motor yağını arada değiştirmeyi ve duvarlara çarpmamaya özen göstermelisin."
	, "Ve ayrıca duvara çarpınca motorun hasar yediği yetmezmiş gibi duvara hasar verdiğin için pist yönetiminden ayrıca para cezası yersin."
	, "Hızlı para kazanmak istiyorsan kurallara dikkat etmeye çalış."
	, "Birazda tekerlek düzeylerini anlatayım."
	, "Marketten 4 tane tekerlek düzeyi satın alabilirsin."
	, "1-Süper Yumuşak -> En iyi yol tutuşu sağlar.\n     2-Orta\n     3-Sert\n     4-Konfor            -> En kötü yol tutuşu sağlar."
	, "En iyi yol tutuşunu süper yumuşaklar sağlar ancak pahalıdırlar ve hemen yıpranırlar.Bu yüzden aldığın tekerlekleri iyi değerlendirmelisin."
	, "Eğer hiç tekerlek almazsan yol tutuşun en düşük seviyede olur.Arabayı kullanman zorlaşır."
	, "..."
	, "..."
]
				
func _ready():
	modulate = Color(1, 1, 1, 0)
	label.visible_ratio = yuzde
	pass

func _process(delta):
	Input.action_press("ui_down")
	if Input.is_action_pressed("ui_up"):
		Input.action_release("ui_up")
		
	if Global.Save.get_save()["tutorial"]["giris"] < yaziliste.size():
		yazi = yaziliste[Global.Save.get_save()["tutorial"]["giris"]]
	else :
		Input.action_release("ui_down")
		call_deferred("free")
	
	label.text = "     " + yazi
	
	yuzde += delta
	
	label.visible_ratio = yuzde
	
	if fade < 1:
		fade += delta * 3
		$".".modulate = Color(1, 1, 1, fade)
	
	if label.visible_characters > ses:
		ses = label.visible_characters
		$ses.play()
		
func _on_Button_pressed():
	if label.visible_ratio > 0.5:
		yuzde = 0
		ses = 0
		
		if not dur.has(int(Global.Save.get_save()["tutorial"]["giris"])):
			Global.Save.get_save()["tutorial"]["giris"] += 1
		
		if Global.Save.get_save()["tutorial"]["giris"] != tutoset:
			tutoset = Global.Save.get_save()["tutorial"]["giris"]
		else:
			Input.action_release("ui_down")
			yuzde = 1
			var tween : Tween = create_tween()
			tween.tween_property(self,"modulate",Color(0,0,0,0),1)
			tween.tween_callback(cikis)

func cikis():
	Global.Save.save_game()
	call_deferred("queue_free")
