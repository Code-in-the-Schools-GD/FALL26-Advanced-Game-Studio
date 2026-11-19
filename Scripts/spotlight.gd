class_name SpotLight extends PointLight2D


@export var target: Node2D


func _init() -> void:
	texture = preload("res://Resources/Textures/spotlight.tres")
	scale.y = 30
	scale.x = 3
	offset.y = -30


func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		queue_free()
		return
	
	position = position.lerp(target.position, delta * 6)
	rotation = (position + offset).angle_to(target.position)
