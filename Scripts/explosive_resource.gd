class_name ExplosiveResource extends Resource
## Class for holding data to create an [Explosive]


## The radius of this explosion
@export var radius: float = 100.0
## The magnitude of momentum that should be applied to explosive victims (multiplied by 100 in calculations)
@export var strength: float = 30.0
## The damage this explosion does
@export var damage: float = 50.0
## Wether damage scales with the distance from the center of the explosion 
## ([member damage] becomes the max damage in this case)
@export var damage_scales_with_distance: bool = false
## If this explosive should explode when something enters its area
@export var trap := false
## The delay before explosion when the trap is activated
@export var trap_delay: float = 0.0


## Creates a new [Explosive] from this resource's data
func to_node() -> Explosive:
	return Explosive.from_resource(self)
