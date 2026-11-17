extends Node

@onready var audio_player: AudioStreamPlayer = AudioManagement.get_child(0)

func _ready() -> void:
	play("res://Sounds/Beginning BG Music.mp3")

func play(audio_path: String):
	audio_player.stream = load(audio_path)
	audio_player.play()
