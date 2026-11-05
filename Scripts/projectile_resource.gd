class_name ProjectileResource extends Resource


@export var attributes: Array[ProjectileAttribute]
@export var can_rotate: bool = true

@export var damage: int


func make_projectile() -> Projectile:
	return null


func has_attribute(id: String) -> bool:
	for att in attributes:
		if att.id == id:
			return true
	return false
