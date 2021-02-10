extends TextureProgress

export var suspicion_meter_multiplier = 2


func _ready():
	value = 0
	
	
func _process(delta):
	value -= step
	
	
func player_seen():
	value += step * suspicion_meter_multiplier
	
	if value == max_value:
		_end_game()
		
		
func _end_game():
	get_tree().quit()
