extends Node
## Manages functions and variables for sounds
class_name SoundManagerScript

## Reference to the AudioStreamPlayer
@onready var audio_player: AudioStreamPlayer = AudioManagement.get_child(0)

## Plays an audio from a path using a specified bus and volume
func play(audio_path: String, bus: String = "Master", volume_percent: float = 100.0):
	audio_player.stream = load(audio_path)
	audio_player.bus = bus
	audio_player.volume_db = volume_percent / 100
	audio_player.play()
