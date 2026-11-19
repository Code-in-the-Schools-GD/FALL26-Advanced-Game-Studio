extends Node
## Manages functions and variables for sounds
class_name SoundManagerScript

## Path to the audio that plays in [member play_music]
var music_path = "res://Sounds/Beginning BG Music.mp3"
## Determines if [member play_music] keeps looping
var do_music = true

## Plays a sound from a path using a specified bus and volume (in percent) [br]
## DON'T USE FOR MUSIC
func play_sfx(audio_path: String, loop: bool = false, volume_percent: float = 100.0, bus: String = "Master"):
	var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()
	AudioManagement.add_child(audio_player)
	audio_player.stream = load(audio_path)
	audio_player.bus = bus
	audio_player.volume_db = volume_percent / 100
	audio_player.play()
	while audio_player.playing:
		await get_tree().create_timer(0.1).timeout
	if loop:
		play_sfx(audio_path, loop, volume_percent, bus)


## Plays audio at [member music path] in a loop until [member do_music] is false [br]
## Takes in a bus and volume (in percent)
func play_music(volume_percent: float = 100.0, bus: String = "Master"):
	var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()
	AudioManagement.add_child(audio_player)
	audio_player.stream = load(music_path)
	audio_player.bus = bus
	audio_player.volume_linear = volume_percent / 100
	audio_player.play()
	while audio_player.playing:
		await get_tree().create_timer(0.1).timeout
	if do_music:
		play_music(volume_percent, bus)
