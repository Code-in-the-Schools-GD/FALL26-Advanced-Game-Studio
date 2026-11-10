extends Camera2D
## Controller for the [Player]'s camera
class_name Camera

## The position that the camera moves to
var target_pos: Vector2
## Is the camera being affected by a [CameraLock]?
var is_locked: bool = false

func _ready() -> void:
	target_pos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not Globals.is_multiplayer:
		if not is_locked:
			target_pos = get_tree().get_first_node_in_group("Player").position
			target_pos.y += Input.get_axis("Up", "Down") * 70
			target_pos.y -= 50
		position = lerp(position, target_pos, 0.05)
	if Input.is_action_just_pressed("mouse_1"):
		camera_lock(Vector2(5,0))
	if Input.is_action_just_pressed("mouse_2"):
		remove_camera_lock()

## Fixes the camera to a position
func camera_lock(target: Vector2):
	is_locked = true
	target_pos = target

## Unfixes the camera and resets the [member target_pos] to the [Player]
func remove_camera_lock():
	is_locked = false
	target_pos = get_tree().get_first_node_in_group("Player").position
