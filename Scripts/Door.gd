extends Area2D


export(Array, AudioStream) var open_door_sounds
export(Array, AudioStream) var close_door_sounds

onready var _audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D
onready var _animation_player : AnimationPlayer = $AnimationPlayer

var _rdm_audio_clip : int
var _in_door_area : bool = false
var _is_door_open : bool = false


func _ready():
	GameEvents.connect("open_door", self, "_on_open_door")
	randomize()
	
	
func _on_open_door():
	if _in_door_area:
		_open_door()


func _on_Door_body_entered(body):
	if body.collision_layer == 1:
		_in_door_area = true
	else:
		_open_door()


func _on_Door_body_exited(body):
	if body.collision_layer == 1:
		_in_door_area = false


func _open_door():
	if not _is_door_open:
		_animation_player.play("open")
		_rdm_audio_clip = int(rand_range(0, open_door_sounds.size()))
		_audio_player.stream = open_door_sounds[_rdm_audio_clip]
		_audio_player.play()
		_is_door_open = true


func _close_door():
	_rdm_audio_clip = int(rand_range(0, close_door_sounds.size()))
	_audio_player.stream = close_door_sounds[_rdm_audio_clip]
	_audio_player.play()
	_is_door_open = false
