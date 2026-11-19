extends Area2D


#@onready var player: Player = get_parent()


func melee_attack(body: Node2D) -> void:
	if body is CombatCharacter and not get_parent():
		body.take_damage(1, PlayerMeleeAttackDamageSource.new())


class PlayerMeleeAttackDamageSource extends PlayerDamageSource:
	
	func get_as_text() -> String:
		return "Killed by player"
	
	
	func get_death_message(name: String) -> String:
		return "Bum %s was fried by player" % name
