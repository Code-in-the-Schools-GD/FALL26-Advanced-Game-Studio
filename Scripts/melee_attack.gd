class_name MeleeAttack extends Attack


@export var base_damage: int
@export var area: Area2D


func _ready() -> void:
	pass


func execute() -> void:
	for node: Node2D in get_targeted_nodes():
		attack_node(node)


func attack_node(node: Node2D) -> void:
	if node is CombatCharacter:
		node.take_damage(get_damage(node))


func get_targeted_nodes() -> Array[Node2D]:
	return area.get_overlapping_bodies()


func get_damage(_node: Node2D) -> int:
	return base_damage
