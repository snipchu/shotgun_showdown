extends Node3D
var birdyscene = preload("res://scenes/birdy.tscn")

func _ready() -> void:
	randomize()
	$bird_spawn.start()
	$gamelength.start()

func _on_bird_spawn_timeout() -> void:
	var birdy = birdyscene.instantiate()
	birdy.position.x = 0
	birdy.position.z = -10+(randf()*6)
	birdy.position.y = randf_range(1,3)
	print("Spawning bird at X="+str(birdy.position.x)+"\tY="+str(birdy.position.y)+"\tZ="+str(birdy.position.z))
	add_child(birdy)

func _on_gamelength_timeout() -> void:
	print("Game has ended!")
	$bird_spawn.stop()
