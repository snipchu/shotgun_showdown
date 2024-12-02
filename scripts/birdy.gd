extends AnimatableBody3D
signal death
var coin : int
var speed : float
var birdtype : int
@onready var anim: AnimatedSprite3D = $AnimatedSprite3D
@onready var coll: CollisionPolygon3D = $CollisionPolygon3D

func _get_coin() -> int: return coin
func get_bird() -> int: return birdtype

func start() -> void:
	add_to_group("birds")
	coin = -1 if (randi_range(0,1)==0) else 1
	birdtype = randi_range(0,0)
	anim.play("bird1")
	anim.flip_h = coin==-1
	speed = randf_range(3,6)

func _process(delta: float) -> void:
	position.x += speed*delta*coin
	if (position.x>15 || position.x<-15): queue_free()
	
func _on_death(points):
	print("I just died!")
	queue_free()
