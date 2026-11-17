extends Node2D
## Locks the position of the camera while in range to this node's position with an offset
class_name CameraLock

## Range for the camera lock to be triggered
var dist: float = 250.0

# You can just center the point but this is here just in case
## X offset of the camera when the lock is triggered
@export var x_offset: float = 0.0
## Y offset of the camera when the lock is triggered
@export var y_offset: float = 0.0

## Reference for the camera
@onready var camera: Camera = get_tree().get_first_node_in_group("Camera")
## Reference for the player
@onready var player: Player = get_tree().get_first_node_in_group("Player")

func _process(_delta: float) -> void:
	if position.distance_to(player.position) <= dist:
		camera.camera_lock(position + Vector2(x_offset, y_offset))
	else:
		camera.remove_camera_lock()
