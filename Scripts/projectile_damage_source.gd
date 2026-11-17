class_name ProjectileDamageSource extends DamageSource


var proj: Projectile


func get_as_text() -> String:
	return "Shot by " + proj.resource.proj_name


func get_death_message(_name: String) -> String:
	if owner == null:
		return get_as_text()
	return get_as_text() + " from " + owner.name
