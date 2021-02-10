extends "res://Scripts/Character.gd"

const FOV_TOLERANCE = 22.5
const RED = Color(1, 0, 0)
const WHITE = Color(1, 1, 1)
const MAX_DETECTION_DISTANCE = 320

onready var torch = get_node("Torch")
onready var Player = get_node("/root/Level1/Player")


func _ready():
	Player = get_node("/root").find_node("Player", true, false)


func _process(delta):
	if Player_is_in_FOV_TOLERANCE() and Player_is_in_LOS():
		torch.color = RED
		get_tree().call_group("suspicion_meter", "player_seen")
	else:
		torch.color = WHITE


func Player_is_in_FOV_TOLERANCE():
	var NPC_facing_direction = Vector2(1, 0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()

	if abs(direction_to_Player.angle_to(NPC_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false


func Player_is_in_LOS():
	var space = get_world_2d().direct_space_state
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self], collision_mask)
	
	if not LOS_obstacle:
		return false
	
	var distance_to_player = Player.global_position.distance_to(global_position)
	
	if LOS_obstacle.collider == Player and distance_to_player < MAX_DETECTION_DISTANCE:
		return true
	else:
		return false
