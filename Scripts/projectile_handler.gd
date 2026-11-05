class_name ProjectileHandler extends Node2D


@export var active_proj: ProjectileResource


func shoot(dir: Vector2) -> void:
	fire_proj(active_proj.make_projectile(), dir)


func fire_proj(proj: Projectile, dir: Vector2, vel_strength: float = 1000) -> void:
	get_tree().root.get_child(-1).add_child(proj)
	proj.velocity = dir * vel_strength
