extends Area2D


func _on_body_entered(body):
	if body.has_method("collect_loot"):
		body.collect_loot()
		queue_free()
	else:
		printerr("body has not the right method to loot this item")