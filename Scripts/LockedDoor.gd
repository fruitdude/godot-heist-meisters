extends "res://Scripts/Door.gd"



onready var numpad = $CanvasLayer/Numpad
onready var _label = $Label


func _ready(): 
	_label.rect_rotation = -rotation_degrees

	
func _on_open_door():
	if _in_door_area:
		$CanvasLayer/Numpad.popup_centered()


func _on_LockedDoor_body_exited(body):
	$CanvasLayer/Numpad.hide()
	numpad._reset_display()
	
	
func _on_Numpad_combination_correct():
	_open_door()
	$CanvasLayer/Numpad.hide()


func _on_Computer_combination(numbers, lock_group):
	$CanvasLayer/Numpad.combination = numbers
	$Label.text = lock_group
