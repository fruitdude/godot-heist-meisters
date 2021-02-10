extends "res://Scripts/Character.gd"


var _motion = Vector2()
var _disguised = false

export(NodePath) onready var _sprite = get_node(_sprite) as Sprite
export(NodePath) onready var _light_occluder = get_node(_light_occluder) as LightOccluder2D
export(NodePath) onready var _light = get_node(_light) as Light2D 
export(Resource) var _player_sprite = _player_sprite as Texture
export(Resource) var _box_sprite = _box_sprite as Texture
export(Resource) var _human_occluder = _human_occluder as OccluderPolygon2D
export(Resource) var _box_occluder = _box_occluder as OccluderPolygon2D


func _process(delta):
	update_motion(delta)
	move_and_slide(_motion)
	
	
func update_motion(delta):
	look_at(get_global_mouse_position())
	_motion = Vector2()
	
	if Input.is_action_pressed("move_right"):
		_motion.x += 1
	if Input.is_action_pressed("move_left"):
		_motion.x -= 1
	if Input.is_action_pressed("move_down"):
		_motion.y += 1
	if Input.is_action_pressed("move_up"):
		_motion.y -= 1
		
	_motion = _motion.normalized() * SPEED


func _input(event):
	if Input.is_action_just_pressed("toggle_visionmode"):
		GameEvents.emit_signal("toggle_visionmode")
	
	if Input.is_action_just_pressed("interact"):
		GameEvents.emit_signal("open_door")
		GameEvents.emit_signal("interact")
		
	if Input.is_action_just_pressed("toggle_disguise"):
		_toggle_disguise()
		
		
func _toggle_disguise():
	if _disguised:
		_reveal()
	else:
		_disguise()
		
		
func _reveal():
	_sprite.texture = _player_sprite
	_light.texture = _player_sprite
	_disguised = false
	collision_layer = 1
	_light_occluder.occluder = _human_occluder
	
	
	
func _disguise():
	_sprite.texture = _box_sprite
	_light.texture = _box_sprite
	_disguised = true
	collision_layer = 16
	_light_occluder.occluder = _box_occluder