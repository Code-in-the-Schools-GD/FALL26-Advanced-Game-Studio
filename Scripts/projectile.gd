class_name Projectile extends CharacterBody2D


signal landed(on: Node2D)

@export var resource: ProjectileResource

var damage_source: ProjectileDamageSource

var proj_owner: Node2D

var in_air := true


func _ready() -> void:
	damage_source = ProjectileDamageSource.new()
	damage_source.owner = proj_owner


func _physics_process(delta: float) -> void:
	if in_air:
		velocity += get_gravity() * delta
		
		if resource.can_rotate:
			if is_zero_approx(velocity.x):
				rotation = (3 * PI / 2) + (0.0 if velocity.y < 0 else PI)
			else:
				rotation = atan(velocity.y / velocity.x)
				if velocity.x < 0:
					rotation += PI
		
		move_and_slide()


func land(on: Node2D):
	landed.emit(on)
	if on is CombatCharacter:
		on.take_damage(resource.damage, damage_source)


func calculate_dir(starting_pos: Vector2, target: Vector2, strength: float) -> Vector2:
	if not resource.experiences_gravity:
		return starting_pos.direction_to(target)
	
	var displacement: Vector2 = target - starting_pos
	displacement.y *= -1
	var squared = pow(strength, 2)
	var negative = pow(-get_gravity().y, 2) * pow(displacement.x, 2)
	var positive = 2 * -get_gravity().y * squared * displacement.y
	var discriminant = pow(squared, 2) - negative + positive
	if discriminant < 0.0:
		return Vector2.ZERO
	var sqrtd = sqrt(discriminant)
	var inside = (squared - sqrtd) / (-get_gravity().y * displacement.x)
	var angle = atan(inside)
	if angle < 0:
		angle += PI
	var dir = Vector2.from_angle(angle)
	
	return dir
