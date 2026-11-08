@tool
class_name Explosive extends Area2D


@export var radius: float = 100.0:
	set(v):
		radius = v
		get_child(0).shape.radius = v
@export var strength: float = 30.0

@export_group("Trap")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var trap := false:
	set(v):
		trap = v
		if v:
			body_entered.connect(activate_trap)
		else:
			body_entered.disconnect(activate_trap)
@export var trap_delay: float = 0.0


static func from_resource(ex: ExplosiveResource) -> Explosive:
	return Explosive.new(ex.radius, ex.strength, ex.trap, ex.trap_delay)


func _init(r: float = 100.0, st: float = 30, trp := false, trpd: float = 0.0) -> void:
	radius = r
	strength = st
	trap = trp
	trap_delay = trpd
	
	var collision := CollisionShape2D.new()
	collision.shape = CircleShape2D.new()
	collision.shape.radius = radius
	if trap:
		body_entered.connect(activate_trap)
	add_child(collision)
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(3, true)


func check_for_trap() -> void:
	var bodies := get_overlapping_bodies()
	if not bodies.is_empty():
		activate_trap(bodies[0])


func activate_trap(_node: Node2D) -> void:
	if not (is_zero_approx(trap_delay) or trap_delay < 0.0):
		await get_tree().create_timer(trap_delay).timeout
	explode()


func explode() -> void:
	for node: Node2D in get_overlapping_bodies():
		explode_node(node)


func explode_node(node: Node2D) -> void:
	var dir := position.direction_to(node.position)
	var dist := position.distance_to(node.position) / radius
	dist = clampf(dist, 0.0, 1.0)
	assert(node is CombatCharacter)
	node.velocity = (1 - dist) * dir * strength * 100 / node.mass
