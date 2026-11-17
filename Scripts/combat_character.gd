class_name CombatCharacter extends CharacterBody2D


@export var max_health: int = 10
@export var health: int = 10
@export var invulnerable: bool = false
@export var attack_damage: int = 100 #pretty big number acording to luke
@export var mass: float = 50.0
@export var experiences_gravity: bool = true

var last_safe_positions: Array[Vector2]


func _physics_process(_delta: float) -> void:
	if is_on_floor():
		last_safe_positions.append(position)
		last_safe_positions.remove_at(0)


func take_damage(damage: int, source: DamageSource = null, _take_offense: bool = true) -> void:
	if not invulnerable:
		health -= damage
		print(damage,"taken",health,"Remaining")
	if health <= 0:
		die(source)


@warning_ignore("unused_parameter")
func die(damage_source: DamageSource = null) -> void:
	queue_free()


func fall_into_hazard(hazard: Hazard) -> void:
	die(hazard.damage_source)


func teleport_to_last_safe_position(remove_velocity := true) -> void:
	if remove_velocity: 
		velocity = Vector2.ZERO
	position = last_safe_positions[0]
