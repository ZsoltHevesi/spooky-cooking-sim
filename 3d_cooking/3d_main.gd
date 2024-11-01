extends Node3D

var grabbed_object = null
var Zpos = 8
var mouse = Vector2()
var grab_position = Vector2()
const DIST = 1000

func _process(delta: float) -> void:
	if grabbed_object:
		grabbed_object.position = get_grab_position()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse = event.position
	if event is InputEventMouseButton:
		if event.pressed == false and event.button_index == MOUSE_BUTTON_LEFT:
			get_mouse_world_pos(mouse)
		elif event.pressed == false and event.button_index == MOUSE_BUTTON_RIGHT:
			grabbed_object = null

func get_mouse_world_pos(mouse:Vector2):
	var space = get_world_3d().direct_space_state
	var start = get_viewport().get_camera_3d().project_ray_origin(mouse)
	var end = get_viewport().get_camera_3d().project_position(mouse, DIST)
	var params = PhysicsRayQueryParameters3D.new()
	params.from = start
	params.to = end

	var result = space.intersect_ray(params)
	
	if result.is_empty() == false:
		grabbed_object = result.collider

func get_grab_position():
	return get_viewport().get_camera_3d().project_position(mouse, Zpos)
