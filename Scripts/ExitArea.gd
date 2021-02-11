extends ColorRect




func _on_Area2D_body_entered(body):
	if body.has_node("Loot"):
		get_tree().quit()
