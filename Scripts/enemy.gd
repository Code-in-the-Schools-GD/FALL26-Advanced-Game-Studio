class_name Enemy extends CombatCharacter


@export var kinetic_friction: float = 2.1
@export var air_resistance: float = 0.8

@export var agro_dist: float = 400.0
@export var max_agro_dist: float = 550.0

var current_agro: CombatCharacter
var inanimate_agro: Node2D
var arena: Arena


func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_layer_value(3, true)


func _physics_process(delta: float) -> void:
	if not is_on_floor() and experiences_gravity:
		velocity += get_gravity() * delta
	velocity.x = move_toward(velocity.x, 0, kinetic_friction if is_on_floor() else air_resistance)
	super(delta)
	move_and_slide()


func take_damage(damage: int, source: DamageSource = null, take_offense: bool = true) -> void:
	super(damage, source, take_offense)
	if take_offense:
		if source.owner is CombatCharacter:
			current_agro = source.owner
		else:
			inanimate_agro = source.owner


func get_agro() -> CombatCharacter:
	if current_agro != null:
		if position.distance_to(current_agro.position) < max_agro_dist:
			return current_agro
	var closest: CombatCharacter = null
	var closest_dist: float
	for character: CombatCharacter in get_tree().get_nodes_in_group(&"Player"):
		var current_dist: float = character.position.distance_to(position)
		if closest == null or closest_dist > current_dist:
			if current_dist < agro_dist:
				closest = character
				closest_dist = current_dist
	current_agro = closest
	
	return closest
