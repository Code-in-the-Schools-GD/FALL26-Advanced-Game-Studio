## Handels the arenas
class_name Arena extends Area2D


@warning_ignore("unused_signal")
## Fires when a wave is completed
signal wave_cleared

## List of enemies in the waves
@export var waves: Array[Array]

## The number representing the wave the player is on
var current_wave: int
## The number of enemies defeated
var amount_defeated: int
## Is the arena done?
var completed_arena: bool = false


func _ready() -> void:
	for wave_idx: int in $Waves.get_child_count():
		for enemy: Enemy in $Waves.get_child(wave_idx).get_children():
			if wave_idx > waves.size() - 1:
				waves.append([])
			waves[wave_idx].append(enemy)
	
	for wave: Array in waves:
		for enemy: Enemy in wave:
			enemy.arena = self
			enemy.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
