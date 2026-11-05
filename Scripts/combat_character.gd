class_name CombatCharacter extends CharacterBody2D


@export var max_health: int = 10
@export var health: int = 10
@export var invulnerable: bool = true
@export var attact_damage: int = 100 #pretty big number acording to luke


@warning_ignore("unused_parameter")
func die(damage_source: DamageSource = null) -> void:
	queue_free()
