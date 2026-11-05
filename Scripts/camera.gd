extends Camera2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Globals.is_multiplayer:
		position = lerp(position, get_tree().get_first_node_in_group("Player").position, 0.05)
		
