extends Interactible
@onready var camera_3d: Camera3D = $Camera3D
@onready var stove: StaticBody3D = $"."
@onready var top_bun_spawn: Spawner = $top_bun_spawn
@onready var bottom_bun_spawn: Spawner = $bottom_bun_spawn
@onready var patty_spawn: Spawner = $patty_spawn
@onready var lettuce_spawn: Spawner = $lettuce_spawn

var is_in_use : bool = false

var grabbed_object = null
var mouse = Vector2()
const DIST = 1000
const FIXED_Y = 0.65

var instance

func _ready() -> void:
	top_bun_spawn.spawn_new()
	bottom_bun_spawn.spawn_new()
	patty_spawn.spawn_new()
	lettuce_spawn.spawn_new()
	set_physics_process(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RMB") and is_in_use:
		camera_3d.current = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_node("../player").hud.visible = true
		get_node("../player").set_physics_process(true)
		set_physics_process(false)
		is_in_use = false
	if event is InputEventMouseMotion:
		mouse = event.position
	if event is InputEventMouseButton:
		# Mouse pressed
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			grabbed_object = get_grabbed_object(mouse)
		# Mouse released
		elif not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			grabbed_object = null

func _on_interacted(body: Variant) -> void:
	if !is_in_use:
		camera_3d.current = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_node("../player").hud.visible = false
		get_node("../player").set_physics_process(false)
		is_in_use = true
		set_physics_process(true)

func _process(delta: float) -> void:
	if grabbed_object and grabbed_object.is_in_group("grabbable"):
		grabbed_object.position = get_grab_position()

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
