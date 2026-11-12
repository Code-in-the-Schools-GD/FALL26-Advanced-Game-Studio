extends Enemy



func _physics_process(delta: float) -> void:
	super(delta)
	
	get_agro()
	
	if current_agro != null:
		var dir: Vector2
		dir.x = -1 if current_agro.position < position else 1
		
		if position.distance_to(current_agro.position) < 130:
			#print($MeleeAttack.active)
			if not $MeleeAttack.active:
				$MeleeAttack.execute()
		else:
			velocity.x = dir.x * 130
		
		for node: Node in get_children():
			if node is MeleeAttack:
				if node.flippable:
					node.scale.x = dir.x
