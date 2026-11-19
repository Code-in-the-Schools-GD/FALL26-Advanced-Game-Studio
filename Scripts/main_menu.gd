extends Control


func start() -> void:
	SoundManager.play_music(50, "REVERB")
	get_tree().change_scene_to_file("res://Scenes/act_1.tscn")
