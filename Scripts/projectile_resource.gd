class_name ProjectileResource extends Resource


@export var attributes: Array[ProjectileAttribute]
@export var can_rotate: bool = true

@export var texture: Texture2D

@export var damage: int


func make_projectile() -> Projectile:
	var proj := Projectile.new()
	var sprite := Sprite2D.new()
	sprite.texture = texture
	proj.add_child(sprite)
	return proj


func has_attribute(id: String) -> bool:
	for att in attributes:
		if att.id == id:
			return true
	return false
