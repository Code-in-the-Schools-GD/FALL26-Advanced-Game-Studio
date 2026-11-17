@tool
class_name Explosive extends Area2D
## An explosive.


@export var explosive_owner: Node = null
@export var damage_source: ExplosionDamageSource

## The radius of this explosion
@export var radius: float = 100.0:
	set(v):
		radius = v
		get_child(0).shape.radius = v
## The magnitude of momentum that should be applied to explosive victims (multiplied by 100 in calculations)
@export var strength: float = 30.0
## The damage this explosion does
@export var damage: float = 50.0
## Wether damage scales with the distance from the center of the explosion 
## ([member damage] becomes the max damage in this case)
@export var damage_scales_with_distance: bool = false

@export_group("Trap")
## If this explosive should explode when something enters its area
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var trap := false:
	set(v):
		trap = v
		if v:
			body_entered.connect(activate_trap)
		else:
			if body_entered.is_connected(activate_trap):
				body_entered.disconnect(activate_trap)
## The delay before explosion when the trap is activated
@export var trap_delay: float = 0.0


## Creates a new [Explosive] from the data in [param ex]
static func from_resource(ex: ExplosiveResource, ex_owner: Node = null) -> Explosive:
	return Explosive.new(ex_owner, ex.radius, ex.strength, ex.trap, ex.trap_delay)


func _init(ex_owner: Node = null, r: float = 100.0, st: float = 30, d: float = 50.0, dswd := false, trp := false, trpd: float = 0.0) -> void:
	var collision := CollisionShape2D.new()
	collision.shape = CircleShape2D.new()
	collision.shape.radius = radius
	if trap:
		body_entered.connect(activate_trap)
	add_child(collision)
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(3, true)
	damage_source = ExplosionDamageSource.new(self)
	
	explosive_owner = ex_owner
	radius = r
	strength = st
	damage = d
	damage_scales_with_distance = dswd
	trap = trp
	trap_delay = trpd


## Activates trap if there are any bodies in the area
func check_for_trap() -> void:
	var bodies := get_overlapping_bodies()
	if not bodies.is_empty():
		activate_trap(bodies[0])


## Waits for [member trap_delay], if applicable, then [method explode]s
func activate_trap(_node: Node2D) -> void:
	if not (is_zero_approx(trap_delay) or trap_delay < 0.0):
		await get_tree().create_timer(trap_delay).timeout
	explode()


## Runs [method explode_node] on all bodies in the area.
func explode() -> void:
	for node: Node2D in get_overlapping_bodies():
		assert(node is CombatCharacter)
		explode_node(node)


## Applies momentum and damage from this explosion to [param node].
func explode_node(node: CombatCharacter) -> void:
	var dir := position.direction_to(node.position)
	var dist := position.distance_to(node.position) / radius
	dist = clampf(dist, 0.0, 1.0)
	node.velocity = (1 - dist) * dir * strength * 100 / node.mass
	var total_damage: float = damage
	if damage_scales_with_distance:
		total_damage *= (1 - dist)
	node.take_damage(roundi(total_damage), damage_source)


class ExplosionDamageSource extends DamageSource:
	
	
	var explosive: Explosive
	
	
	func _init(ex: Explosive) -> void:
		explosive = ex
		owner = ex.explosive_owner
	
	
	func get_as_text() -> String:
		return "Exploded by %s" % explosive
	
	
	func get_death_message(_name: String) -> String:
		if not is_instance_valid(owner):
			return get_as_text()
		return get_as_text() + " from %s" % owner.name
