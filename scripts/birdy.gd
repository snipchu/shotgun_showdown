extends AnimatableBody3D

var coin : int
var speed : float

func _get_coin() -> int: return coin

func start() -> void:
	coin = -1 if (randi_range(0,1)==0) else 1
	speed = randf_range(3,6)
	
func _process(delta: float) -> void:
	position.x += speed*delta if _get_coin()==1  else -speed*delta
	if (position.x>15 || position.x<-15): queue_free()
