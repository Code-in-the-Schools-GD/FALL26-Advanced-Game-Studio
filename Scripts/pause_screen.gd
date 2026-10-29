extends Control



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		change_pause()


func change_pause() -> void:
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused


func quit() -> void:
	get_tree().quit()
