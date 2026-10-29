class_name FadeInObject extends Resource


@export var image: Texture2D
@export var sprite_frames: SpriteFrames
@export var scale := Vector2.ONE

var associated_node: CanvasItem


func is_animated() -> bool:
	return sprite_frames != null
