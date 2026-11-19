extends Node


@onready var audio_player: AudioStreamPlayer = AudioManagement.get_child(0)

func play(audio_path: String, bus: String = "Master"):
	audio_player.stream = load(audio_path)
	audio_player.bus = bus
	audio_player.play()
