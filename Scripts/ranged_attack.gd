class_name RangedAttack extends Attack


@export var strength_multiplier = 1.0
@export var max_pullback: float = 4.0

var pullback: float


func execute() -> void:
	active = true
	while pullback < max_pullback:
		await get_tree().process_frame
		pullback += 1 / 60.0
	pullback = max_pullback
	try_shooting(get_arrow_dir())
	await get_tree().create_timer(cooldown).timeout
	active = false


func try_shooting(in_direction: Vector2) -> void:
	var proj := get_currently_selected().make_projectile()
	proj.position = global_position
	proj.velocity = in_direction * 1000 * get_strength()
	proj.proj_owner = get_character()
	get_character().get_parent().add_child(proj)


func get_currently_selected() -> ProjectileResource:
	return preload("res://Resources/Projectiles/flop.tres")


func get_strength() -> float:
	return 1.0


func get_character() -> CombatCharacter:
	return attribution


func get_target() -> Node2D:
	if get_character() is Enemy:
		var agro: Node2D = get_character().get_agro()
		if agro != null:
			return agro
	
	return null


func calculate_dir(starting_pos: Vector2, target: Vector2, strength: float) -> Vector2:
	var g: float = 0.6 * -get_character().get_gravity().y
	
	var displacement: Vector2 = target - starting_pos
	displacement.y *= -1
	var squared = pow(strength, 2)
	var negative = pow(g, 2) * pow(displacement.x, 2)
	var positive = 2 * g * squared * displacement.y
	var discriminant = pow(squared, 2) - negative + positive
	if discriminant < 0.0:
		return Vector2.ZERO
	var sqrtd = sqrt(discriminant)
	var inside = (squared - sqrtd) / (g * displacement.x)
	var angle = atan(inside)
	if angle > 0:
		angle += PI
	var dir = Vector2.from_angle(angle)
	
	return dir


func get_arrow_dir() -> Vector2:
	var target := get_target()
	if target == null:
		return Vector2.ZERO
	return calculate_dir(position, target.position, pullback * 500 * strength_multiplier)
