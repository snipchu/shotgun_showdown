extends RigidBody3D

var coin : int
var speed : float
var birdtype : int
var target_vel := Vector3.ZERO
var notdead := true
@onready var anim: AnimatedSprite3D = $AnimatedSprite3D

func get_coin() -> int: return coin
func get_bird() -> int: return birdtype
func flipacoin() -> void: coin = -1 if (randi_range(0,1)==0) else 1

func _ready() -> void:
	randomize()
	add_to_group("birds")
	if randf()>.15:
		anim.play("bird1")
		birdtype=0
	else:
		anim.play("bird2")
		birdtype=1
	anim.flip_h = coin==-1
	speed = randf_range(300,450)
	
func _process(delta: float) -> void:
	if notdead:
		linear_velocity = Vector3(speed*delta*coin,0,0)
		if (position.x>15 || position.x<-15 || position.y<-10): queue_free()

func death():
	notdead = false
	anim.play("death")
	anim.frame = birdtype
	apply_central_impulse(Vector3(0,randf_range(4,7),0))
	$CollisionShape3D.set_disabled(true)
	gravity_scale=2
