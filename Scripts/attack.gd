class_name Attack extends Node2D


@export var attribution: Node2D
@export var can_attack_self: bool = false
@export var damage_source: DamageSource

@export var active: bool = false
@export var cooldown: float = 2.0


func execute() -> void:
	pass
