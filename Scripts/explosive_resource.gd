class_name ExplosiveResource extends Resource


@export var radius: float = 100.0
@export var strength: float = 30.0
@export var trap := false
@export var trap_delay: float = 0.0


func to_node() -> Explosive:
	return Explosive.from_resource(self)
