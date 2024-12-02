extends Node3D

const SENSITIVITY = .4
const SMOOTHNESS = 15
const LOWER_MAX := -20
const UPPER_MAX := 30
const LEFT_MAX := -50
const RIGHT_MAX := 50
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
	
	if (Input.is_action_just_pressed("shoot")):
		shoot_ray()
	
func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var space_state = get_world_3d().direct_space_state
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000
	var query = PhysicsRayQueryParameters3D.create(from,to)
	query.collide_with_areas = true
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	if (result && result["collider"].is_in_group("birds")):
		signalbus.bird_hit.emit(1)
