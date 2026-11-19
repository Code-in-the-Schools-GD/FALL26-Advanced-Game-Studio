extends Node2D


var star_scene: PackedScene = preload("res://Scenes/star.tscn")

@export var xlim: float = 1920.0
@export var ymax: float = 1080
@export var ymin: float = 720
@export var ymean: float = 900



func _physics_process(_delta: float) -> void:
	if randf() < 0.3:
		var instance = star_scene.instantiate()
		add_child(instance)
		
		var rx = randf() * xlim
		var ry = randf()
		var ypos = ymean
		#Sampling from a normal distribution
		if ry < 0.5 and ry != 0:
			ypos += 90*sqrt(-log(2*ry))
			ypos = min(ymax, ypos)
		if ry > 0.5 and ry != 1:
			ypos += -90 * sqrt(-log(2 - 2 * ry))
			ypos = max(ymin, ypos)
		instance.global_position = Vector2(rx - xlim / 2, ymax / 2 - ypos)
