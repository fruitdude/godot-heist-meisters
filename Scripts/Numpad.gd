extends Popup


signal combination_correct

var combination
var _guess = []

onready var _display_label : Label = $NinePatchRect/VBoxContainer/DisplayContainer/DisplayLabel
onready var _button_container : GridContainer = $NinePatchRect/VBoxContainer/CenterContainer/GridContainer
onready var _pad_light : TextureRect = $NinePatchRect/VBoxContainer/CenterContainer/GridContainer/PadLightTexture
onready var _audiostream_player : AudioStreamPlayer = $AudioStreamPlayer
onready var _timer : Timer = $Timer


func _ready():
	_connect_buttons()
	_reset_display()
	

func _connect_buttons():
	for child in _button_container.get_children():
		if child is Button:
			child.connect("pressed", self, "_on_button_pressed", [child.text])
			

func _on_button_pressed(button):
	if button == "OK":
		_check_guess()
	else:
		_enter(int(button))
	
	
func _check_guess():
	if _guess == combination:
		_audiostream_player.stream = load("res://SFX/threeTone1.ogg")
		_audiostream_player.play()
		_pad_light.texture = load("res://GFX/Interface/PNG/dotGreen.png")
		_timer.start()
	else:
		_reset_display()
	
	
func _enter(button):
	_audiostream_player.stream = load("res://SFX/twoTone1.ogg")
	_audiostream_player.play()
	_guess.append(button)
	_update_display()
	
	
func _update_display():
	_display_label.text = PoolStringArray(_guess).join("")
	if _guess.size() == combination.size():
		_check_guess()
	
	
func _reset_display():
	_display_label.text = ""
	_guess.clear()
	_pad_light.texture = load("res://GFX/Interface/PNG/dotRed.png")


func _on_Timer_timeout():
	emit_signal("combination_correct")
	_reset_display()
	
