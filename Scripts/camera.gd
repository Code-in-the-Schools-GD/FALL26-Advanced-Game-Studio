extends Camera2D

var target_pos: Vector2

func _ready() -> void:
	target_pos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not Globals.is_multiplayer:
		target_pos = get_tree().get_first_node_in_group("Player").position
		target_pos.y += Input.get_axis("Up", "Down") * 70
		target_pos.y -= 50
		position = lerp(position, target_pos, 0.05)
