extends Enemy



func _physics_process(delta: float) -> void:
	super(delta)
	
	get_agro()
	
	if current_agro != null:
		if position.distance_to(current_agro.position) < 150:
			#print($MeleeAttack.active)
			if not $MeleeAttack.active:
				$MeleeAttack.execute()
		else:
			velocity.x = (get_agro().position.x - position.x) * 3
