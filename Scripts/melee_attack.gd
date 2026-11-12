class_name MeleeAttack extends Attack


@export var flippable: bool = true
@export var cooldown: float = 2.0
@export var attack_time: float = 1.0
@export var base_damage: int = 10
@export var area: Area2D
@export var active: bool = false


func _ready() -> void:
	pass


func execute() -> void:
	active = true
	for node: Node2D in get_targeted_nodes():
		attack_node(node)
	area.body_entered.connect(attack_node)
	await get_tree().create_timer(attack_time).timeout
	area.body_entered.disconnect(attack_node)
	await get_tree().create_timer(cooldown).timeout
	active = false


func attack_node(node: Node2D) -> void:
	if node is CombatCharacter and node != attribution:
		node.take_damage(get_damage(node), damage_source)


func get_targeted_nodes() -> Array[Node2D]:
	return area.get_overlapping_bodies()


func get_damage(_node: Node2D) -> int:
	return base_damage
