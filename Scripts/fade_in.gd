extends Control


@export var order: Array[FadeInObject]

@export var fade_in_time: float = 60.0
@export var wait_time: float = 60.0
@export var fade_out_time: float = 60.0


func _ready() -> void:
	for obj: FadeInObject in order:
		add_fade_node(obj)
	for obj: FadeInObject in order:
		obj.associated_node.show()
		if obj.is_animated():
			obj.associated_node.play("default")
			await obj.associated_node.animation_finished
		else:
			obj.associated_node.modulate.a = 0.0
			for i in range(fade_in_time):
				obj.associated_node.modulate.a += 1 / fade_in_time
				await get_tree().process_frame
		for i in range(wait_time):
			await get_tree().process_frame
		for i in range(fade_out_time):
			obj.associated_node.modulate.a -= 1 / fade_out_time
			await get_tree().process_frame
		obj.associated_node.hide()
	
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func add_fade_node(fade_res: FadeInObject) -> void:
	if fade_res.is_animated():
		var anim := AnimatedSprite2D.new()
		anim.sprite_frames = fade_res.sprite_frames
		anim.position = get_viewport_rect().size / 2
		anim.scale = fade_res.scale
		anim.hide()
		fade_res.associated_node = anim
		$Animated.add_child(anim)
	else:
		var rect := TextureRect.new()
		rect.texture = fade_res.image
		get_tree().process_frame.connect(func(): rect.custom_minimum_size = fade_res.scale * rect.size, CONNECT_ONE_SHOT)
		rect.hide()
		fade_res.associated_node = rect
		$Statics.add_child(rect)
