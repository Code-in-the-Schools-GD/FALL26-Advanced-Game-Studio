extends Sprite2D


var brightness: float = 0.0
var totaltime: float = 0.0



func _ready() -> void:
	var starid: int = randi_range(0, 3)
	texture = load("res://Sprites/Stages/Act I/Stars/star_" + str(starid) +".png")
	var rscale: float = 1 + (0.3 * (randf() - 0.5))
	scale = Vector2.ONE * rscale * 1.0 * 7.0 / (5.0 + starid)
	rotate(randf() * PI / 2)


func _process(delta: float) -> void:
	brightness = totaltime * (-totaltime + 2.5) / 1.5625
	totaltime += delta
	modulate = Color.from_hsv(0.0, 0.0, 0.7 * brightness + 0.3, brightness)
	if brightness < 0:
		queue_free()
