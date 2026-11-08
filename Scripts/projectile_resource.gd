class_name ProjectileResource extends Resource


@export var attributes: Array[ProjectileAttribute]
@export var can_rotate: bool = true
@export var semisolid: bool = false

@export var explosive: ExplosiveResource = null

@export_file var scene_path := ""

@export var texture: Texture2D

@export var damage: int


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
	return proj


func has_attribute(id: String) -> bool:
	for att in attributes:
		if att.id == id:
			return true
	return false
