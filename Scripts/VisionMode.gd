extends CanvasModulate


const DARK = Color("070917")
const NIGHTVISION = Color("348f4f")

onready var nightvision_timer = $NightvisionTimer
onready var nightvision_cooldown_timer = $NightvisionCooldownTimer
onready var audiostreamplayer = $AudioStreamPlayer

var _is_nightvision_off = true


func _ready():
	color = DARK
	GameEvents.connect("toggle_visionmode", self, "_on_toggle_visionmode")


func _on_toggle_visionmode():
	if _is_nightvision_off:
		nightvision_mode()
	else:
		return


func nightvision_mode():
	_is_nightvision_off = false
	color = NIGHTVISION
	audiostreamplayer.stream = load("res://SFX/nightvision.wav")
	audiostreamplayer.play()
	nightvision_timer.start()
	nightvision_cooldown_timer.start()
	get_tree().call_group("lights", "hide")
	get_tree().call_group("labels", "show")
	

func _on_NightVisionTimer_timeout():
	if not _is_nightvision_off:
		dark_mode()
	else:
		return
		
		
func dark_mode():
	color = DARK
	audiostreamplayer.stream = load("res://SFX/nightvision_off.wav")
	audiostreamplayer.play()
	get_tree().call_group("lights", "show") 
	get_tree().call_group("labels", "hide") 


func _on_NightvisionCooldownTimer_timeout():
	_is_nightvision_off = true
