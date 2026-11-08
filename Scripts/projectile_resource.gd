class_name ProjectileResource extends Resource
## Data for different [Projectile]s


## The name of this projectile
@export var proj_name: String
## The [ProjectileAttribute]s that this projectile has
@export var attributes: Array[ProjectileAttribute]
## If this projectile should rotate according to its velocity vector
@export var can_rotate: bool = true
## If this projectile should accelerate due to gravity
@export var experiences_gravity: bool = true
## If this projectile should phase through the ground
@export var semisolid: bool = false
## The [Explosive] that this projectile should spawn
@export var explosive: ExplosiveResource = null
## The scene path to load from, instead of creating programically
@export_file var scene_path := ""
## The texture of this projectile
@export var texture: Texture2D
## How much damage this projectile should do
@export var damage: int


## Makes a new projectile from the stored data, or from the [member scene_path] (if applicable)
func make_projectile() -> Projectile:
	var proj: Projectile
	if scene_path.is_empty():
		proj = Projectile.new()
		var sprite := Sprite2D.new()
		sprite.texture = texture
		proj.add_child(sprite)
		var area := Area2D.new()
		area.set_collision_layer_value(1, false)
		area.set_collision_mask_value(3, true)
		if not semisolid:
			area.set_collision_mask_value(1, true)
	else:
		proj = load(scene_path).instantiate()
	
	if explosive != null:
		var ex_node := explosive.to_node()
		if explosive.trap:
			ex_node.monitoring = false
			proj.landed.connect(func(_n: Node2D): ex_node.monitoring = true; ex_node.check_for_trap())
		else:
			proj.landed.connect(ex_node.explode.unbind(1))
		proj.add_child(ex_node)
	
	proj.resource = self
	return proj


## If this projectile has an attribute with [param id]
func has_attribute(id: String) -> bool:
	for att in attributes:
		if att.id == id:
			return true
	return false
