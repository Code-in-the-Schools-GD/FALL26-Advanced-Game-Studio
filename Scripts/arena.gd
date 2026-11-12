extends Area2D
class_name Arena

signal wave_cleared

@export var waves: Array[Array]

var current_wave: int
var amount_defeated: int
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
			#enemy.disabled = true


func start_arena(player: Player):
	if player.arena != null or completed_arena:
		return
	
	player.arena = self
	
	for wall: StaticBody2D in get_node("Walls").get_children():
		wall.get_child(0).set_deferred("disabled", false)
	
	for wave_idx: int in waves.size():
		current_wave = wave_idx
		var contents: Array[Enemy]
		print(waves)
		print(wave_idx)
		contents.assign(waves[wave_idx])
		
		for enemy in contents:
			enemy.disabled = false
			enemy.dead.connect(enemy_dead, CONNECT_ONE_SHOT)
		
		await wave_cleared
	
	for wall: StaticBody2D in get_node("Walls").get_children():
		wall.get_child(0).set_deferred("disabled", true)
	
	player.arena = null
	completed_arena = true


func enemy_dead():
	amount_defeated += 1
	if amount_defeated >= waves[current_wave].size():
		wave_cleared.emit()
		amount_defeated = 0
