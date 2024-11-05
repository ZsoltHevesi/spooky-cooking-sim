extends StaticBody3D

var grabbed_object = null
var mouse = Vector2()
const DIST = 1000
const FIXED_Y = 1  # Set this to the desired Y position

func use():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta: float) -> void:
	if grabbed_object:
		grabbed_object.position = get_grab_position()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse = event.position
	if event is InputEventMouseButton:
		# Mouse pressed
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			grabbed_object = get_grabbed_object(mouse)
		# Mouse released
		elif not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			grabbed_object = null

func get_grabbed_object(mouse: Vector2):
	var space = get_world_3d().direct_space_state
	var start = get_viewport().get_camera_3d().project_ray_origin(mouse)
	var end = get_viewport().get_camera_3d().project_ray_normal(mouse) * DIST + start
	var params = PhysicsRayQueryParameters3D.new()
	params.from = start
	params.to = end

	var result = space.intersect_ray(params)
	
	if result.is_empty() == false:
		return result.collider
	
	return null

func get_grab_position():
	var start = get_viewport().get_camera_3d().project_ray_origin(mouse)
	var direction = get_viewport().get_camera_3d().project_ray_normal(mouse)
	var distance = (FIXED_Y - start.y) / direction.y
	var pos = start + direction * distance
	pos.y = FIXED_Y  # Lock the Y position
	
	return pos
