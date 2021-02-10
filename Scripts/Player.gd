extends "res://Scripts/Character.gd"


var _motion : Vector2 = Vector2()
var _disguised : bool = false
var _velocity_multiplier : float = 1.0

export var _disguise_slowdown : float = 0.25
export var _disguise_duration : float = 5.0
export var _number_of_disguised : int = 3
export(NodePath) onready var _sprite = get_node(_sprite) as Sprite
export(NodePath) onready var _light_occluder = get_node(_light_occluder) as LightOccluder2D
export(NodePath) onready var _light = get_node(_light) as Light2D
export(NodePath) onready var _collision = get_node(_collision) as CollisionShape2D
export(NodePath) onready var _timer = get_node(_timer) as Timer
export(Resource) var _player_sprite = _player_sprite as Texture
export(Resource) var _box_sprite = _box_sprite as Texture
export(Resource) var _human_occluder = _human_occluder as OccluderPolygon2D
export(Resource) var _box_occluder = _box_occluder as OccluderPolygon2D
export(Resource) var _human_collision = _human_collision as Shape
export(Resource) var _box_collision = _box_collision as Shape


func _ready():
	_timer.wait_time = _disguise_duration


func _process(delta):
	update_motion(delta)
	move_and_slide(_motion * _velocity_multiplier)
	
	if _disguised:
		$DisguiseLabel.text = str(_timer.time_left).pad_decimals(2)
		$DisguiseLabel.rect_rotation = -rotation_degrees
	
	
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
	elif _number_of_disguised > 0:
		_disguise()
		
		
func _reveal():
	_sprite.texture = _player_sprite
	_light.texture = _player_sprite
	_disguised = false
	collision_layer = 1
	_light_occluder.occluder = _human_occluder
	_velocity_multiplier = 1
	_collision.shape = _human_collision
	$DisguiseLabel.hide()
	
	
func _disguise():
	_sprite.texture = _box_sprite
	_light.texture = _box_sprite
	_disguised = true
	collision_layer = 16
	_light_occluder.occluder = _box_occluder
	_velocity_multiplier = _disguise_slowdown 
	_collision.shape = _box_collision
	_timer.start()
	$DisguiseLabel.show()
	_number_of_disguised -= 1