class_name Projectile extends CharacterBody2D


signal landed(on: Node2D)

@export var resource: ProjectileResource

var damage_source: ProjectileDamageSource

var proj_owner: Node2D

var in_air := true


func _ready() -> void:
	damage_source = ProjectileDamageSource.new()
	damage_source.owner = proj_owner
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	get_child(-1).body_entered.connect(land)


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
	in_air = false
	if on is CombatCharacter:
		on.take_damage(resource.damage, damage_source)
