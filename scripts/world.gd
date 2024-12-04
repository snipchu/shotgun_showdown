extends Node3D
const birdyscene = preload("res://scenes/birdy.tscn")
var score = 0

func _ready() -> void:
	randomize()
	signalbus.bird_hit.connect(add_point)
	
func _on_countdown_timeout() -> void:
	$HUD/timer.visible = true
	$HUD/countdown.visible = false
	$gamelength.start()

func _process(_delta: float) -> void:
	$HUD/timer.text = str(floor($gamelength.time_left))
	$HUD/countdown.text = str(floor($countdown.time_left)) if floor($countdown.time_left)!=0 else "START"

func add_point(points):
	score += points
	$HUD/score.text = str(score)
	
func _on_gamelength_timeout() -> void:
	print("Game has ended!")
	$bird_spawn.stop()

func _on_bird_spawn_timeout() -> void:
	var birdy = birdyscene.instantiate()
	birdy.flipacoin()
	birdy.position.z = -10+(randf()*5)
	birdy.position.y = randf_range(0,3)
	birdy.position.x = -8 if (birdy.get_coin()==1) else 8
	add_child(birdy)
