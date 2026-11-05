class_name Projectile extends CharacterBody2D


@export var resource: ProjectileResource

var in_air := true


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
