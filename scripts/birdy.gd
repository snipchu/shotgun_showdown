extends AnimatedSprite3D

var coin : int
var speed : float
var birdtype : int

func _get_coin() -> int: return coin
func get_bird() -> int: return birdtype

func start() -> void:
	coin = -1 if (randi_range(0,1)==0) else 1
	birdtype = randi_range(0,0)
	flip_h = true if (coin==-1) else false
	speed = randf_range(3,6)
	
func shot() -> void:
	play("death")
	frame = birdtype

func _process(delta: float) -> void:
	position.x += speed*delta if _get_coin()==1  else -speed*delta
	if (position.x>15 || position.x<-15): queue_free()
