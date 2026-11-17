extends Sprite2D

var brightness :float = 0.0
var totaltime : float = 0.0

# Called when the node enters the scne tree for the first time.
func _ready() -> void:
	var starid :int = randi() % 4
	texture = load("res://Sprites/Stages/Act I/Stars/star_" + str(starid) +".png")
	var rscale :float = 1+ 0.3*(randf() - 0.5)
	scale = Vector2(rscale*1.0*7.0/(5.0+starid), rscale*1.0*7.0/(5.0+starid))
	var rot :float = randf()*PI/2
	rotate(rot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	brightness = (-totaltime*totaltime+2.5*totaltime)/1.5625
	totaltime += delta
	modulate = Color(0.7*brightness+0.3, 0.7*brightness+0.3, 0.7*brightness+0.3, brightness)
	if brightness < 0:
		queue_free()
