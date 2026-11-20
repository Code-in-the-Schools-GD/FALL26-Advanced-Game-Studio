class_name SpotLight extends PointLight2D


@export var target: Node2D

var cr := ColorRect.new()


func _init() -> void:
	texture = preload("res://Resources/Textures/spotlight.tres")
	scale.y = 30
	scale.x = 3
	offset.y = -30


func _ready() -> void:
	get_tree().current_scene.add_child.call_deferred(cr)
	cr.size = Vector2.ONE * 200


func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		queue_free()
		return
	
	position = position.lerp(target.position, delta * 6)
	rotation = target.position.direction_to(position + offset * scale).angle() + PI/2
	print(rotation_degrees)
	cr.global_position = position + offset * scale
	print(cr.global_position)
