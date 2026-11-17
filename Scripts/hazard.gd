class_name Hazard extends Area2D


@export var hazard_type: String:
	set(v):
		hazard_type = v
		damage_source.hazard_type = v
@export var damage: int = 50

var damage_source := HazardDamageSource.new()


func _on_body_entered(body: Node2D) -> void:
	if body is CombatCharacter:
		body.fall_into_hazard(self)


class HazardDamageSource extends DamageSource:
	
	
	var hazard_type: String
	
	
	func get_as_text() -> String:
		return "Fell into %s" % hazard_type
	
	
	@warning_ignore("unused_parameter")
	func get_death_message(name: String) -> String:
		return get_as_text()
