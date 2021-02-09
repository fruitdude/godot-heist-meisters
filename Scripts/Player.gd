extends "res://Scripts/Character.gd"


var motion = Vector2()


func _process(delta):
	update_motion(delta)
	move_and_slide(motion)
	
	
func update_motion(delta):
	look_at(get_global_mouse_position())
	motion = Vector2()
	
	if Input.is_action_pressed("move_right"):
		motion.x += 1
	if Input.is_action_pressed("move_left"):
		motion.x -= 1
	if Input.is_action_pressed("move_down"):
		motion.y += 1
	if Input.is_action_pressed("move_up"):
		motion.y -= 1
		
	motion = motion.normalized() * SPEED


func _input(event):
	if Input.is_action_just_pressed("toggle_visionmode"):
		GameEvents.emit_signal("toggle_visionmode")
	
	if Input.is_action_just_pressed("interact"):
		GameEvents.emit_signal("open_door")
		GameEvents.emit_signal("interact")
		
	
