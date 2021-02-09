extends Node


signal toggle_visionmode
signal open_door
signal interact


func generate_combination(length):
	var combination = []
	for number in range(length):
		randomize()
		combination.append(randi() % 10)
	return combination
