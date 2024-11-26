extends AnimatableBody3D

var direction : float
var speed : float

func _ready() -> void:
	direction = randf()
	speed = randi_range(5, 10)
	position.x += speed

func _process(delta: float) -> void:
	if (direction>0.5):
		pass
	else:
		pass
	if (position.x < -12 || position.x > 12):
		queue_free()
