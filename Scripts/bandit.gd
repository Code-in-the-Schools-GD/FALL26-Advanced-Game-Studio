extends Enemy


func _physics_process(delta: float) -> void:
	super(delta)
	
	get_agro()
	
	if position.distance_to(current_agro.position) < 150:
		pass
	else:
		velocity.x = (position.x - get_agro().position.x) * 5
