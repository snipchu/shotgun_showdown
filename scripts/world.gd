extends Node3D
var birdyscene = preload("res://scenes/birdy.tscn")

func _ready() -> void:
	randomize()
	await get_tree().create_timer(4).timeout
	$HUD/timer.visible = true
	$HUD/countdown.visible = false
	$gamelength.start()

func _process(delta: float) -> void:
	$HUD/timer.text = str(floor($gamelength.time_left))
	$HUD/countdown.text = str(floor($countdown.time_left)) if floor($countdown.time_left)!=0 else "START"
	
func _on_gamelength_timeout() -> void:
	print("Game has ended!")
	$bird_spawn.stop()

func _on_bird_spawn_timeout() -> void:
	var birdy = birdyscene.instantiate()
	birdy.start()
	birdy.position.z = -10+(randf()*5)
	birdy.position.y = randf_range(0,3)
	birdy.position.x = -10 if (birdy._get_coin()==1) else 10
	add_child(birdy)
	$bird_spawn.wait_time = randf_range(.5,1)
