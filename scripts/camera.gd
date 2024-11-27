extends Node3D

const SENSITIVITY = .4
const SMOOTHNESS = 15
const LOWER_MAX := -20
const UPPER_MAX := 40
const LEFT_MAX := -60
const RIGHT_MAX := 60
@onready var camera = $Camera3D
var camera_input : Vector2
var rotation_velocity : Vector2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion):
		camera_input = event.relative	
		
func _process(delta: float) -> void:
	rotation_velocity = rotation_velocity.lerp(camera_input*SENSITIVITY, SMOOTHNESS*delta)
	rotate_y(-deg_to_rad(rotation_velocity.x))
	rotation.y = clamp(rotation.y, deg_to_rad(LEFT_MAX), deg_to_rad(RIGHT_MAX))
	camera.rotate_x(-deg_to_rad(rotation_velocity.y))
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(LOWER_MAX), deg_to_rad(UPPER_MAX))
	camera_input = Vector2.ZERO
