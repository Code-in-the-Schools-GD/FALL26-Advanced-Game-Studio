extends Node2D

var starprefab =preload("res://star.tscn")

@export var xlim : float = 1920.0
@export var ymax : float = 1080
@export var ymin : float = 720
@export var ymean : float = 900
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var rand = randf();
	if(rand < 0.3):
		var instance = starprefab.instantiate()
		add_child(instance)
		var rx = randf()*xlim
		var ry = randf()
		var ypos = ymean
		#Sampling from a normal distribution
		if(ry < 0.5 and ry != 0):
			ypos += 90*sqrt(-log(2*ry))
			if(ypos > ymax):
				ypos = ymax
		if(ry > 0.5 and ry != 1):
			ypos += -90*sqrt(-log(2-2*ry))
			if(ypos < ymin):
				ypos = ymin
		instance.global_position = Vector2(rx -xlim / 2, ymax/2 - ypos)
