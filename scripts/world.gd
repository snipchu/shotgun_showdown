extends Node3D
@export var birdyscene : PackedScene

func _on_bird_spawn_timeout() -> void:
	print("Timer ended!")
