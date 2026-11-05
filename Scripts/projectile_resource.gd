class_name ProjectileResource extends Resource


var attributes: Array[ProjectileAttribute]


func make_projectile() -> Projectile:
	return null


func has_attribute(id: String) -> bool:
	for att in attributes:
		if att.id == id:
			return true
	return false
