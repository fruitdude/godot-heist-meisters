extends Node2D

signal combination

var combination
var _can_interact : bool = false

export var _combination_length : int = 4
export var lock_group = "Unset"

onready var _computer_light : Light2D = $ComputerLight


func _ready():
	GameEvents.connect("interact", self, "_on_interact")
	generate_combination()
	print(combination)
	emit_signal("combination", combination, lock_group)
	

func _on_interact():
	if _can_interact:
		$CanvasLayer/ComputerPopup.popup_centered()
	
	
func generate_combination():
	combination = GameEvents.generate_combination(_combination_length)
	set_popup_text()
	
	
func set_popup_text():
	$CanvasLayer/ComputerPopup.set_text(combination)
	

func _on_Area2D_body_entered(body):
	_computer_light.enabled = true
	_can_interact = true


func _on_Area2D_body_exited(body):
	_can_interact = false
	$CanvasLayer/ComputerPopup.hide()
	_computer_light.enabled = false
