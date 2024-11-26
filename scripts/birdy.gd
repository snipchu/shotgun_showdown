extends AnimatableBody3D

var coin : float
var speed : float

func get_coin(): return coin

func _ready() -> void:
	coin = -1 if (randi_range(0,1)==0) else 1
	speed = randf_range(2,5)
	print(coin)

func _process(delta: float) -> void:
	position.x += speed*delta if get_coin()==1  else -speed*delta
	if (position.x>15 || position.x<-15): queue_free()
