class_name ProjectileHandler extends Node2D


@export var active_proj: ProjectileResource


func shoot(dir: Vector2) -> void:
	fire_proj(active_proj.make_projectile(), dir)


func fire_proj(proj: Projectile, dir: Vector2) -> void:
	pass
