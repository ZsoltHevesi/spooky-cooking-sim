extends Interactible
@onready var camera_3d: Camera3D = $Camera3D
@onready var stove: StaticBody3D = $"."

@onready var top_bun_spawn: Area3D = $top_bun_spawn
@onready var bottom_bun_spawn: Area3D = $bottom_bun_spawn
@onready var patty_spawn: Area3D = $patty_spawn
@onready var lettuce_spawn: Area3D = $lettuce_spawn

var is_in_use : bool = false

var grabbed_object = null
var mouse = Vector2()
const DIST = 1000
const FIXED_Y = 0.65

var bottom_bun = load("res://_Scenes/burger_bottom_bun.tscn")
var lettuce = load("res://_Scenes/burger_lettuce.tscn")
var patty = load("res://_Scenes/burger_patty.tscn")
#var top_bun = load("res://_Scenes/burger_top_bun.tscn")

var instance

func _ready() -> void:
	#instance = top_bun.instantiate()
	#instance.position = top_bun_spawn.global_position
	#instance.transform.basis = top_bun_spawn.global_transform.basis
	#add_child(instance)
	top_bun_spawn.spawn_new()
	top_bun_spawn.spawn_new()
	instance = bottom_bun.instantiate()
	instance.position = bottom_bun_spawn.global_position
	instance.transform.basis = bottom_bun_spawn.global_transform.basis
	add_child(instance)
	instance = patty.instantiate()
	instance.position = patty_spawn.global_position
	instance.transform.basis = patty_spawn.global_transform.basis
	add_child(instance)
	instance = lettuce.instantiate()
	instance.position = lettuce_spawn.global_position
	instance.transform.basis = lettuce_spawn.global_transform.basis
	add_child(instance)
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

	#if grabbed_object and grabbed_object.is_in_group("spawns"):
		#if grabbed_object.name == "top_bun_spawn":
			#instance = top_bun.instantiate()
			#instance.position = top_bun_spawn.global_position
			#instance.transform.basis = top_bun_spawn.global_transform.basis
			#add_child(instance)
			#print("spawned 1")
		#if grabbed_object.name == "bottom_bun_spawn":
			#instance = bottom_bun.instantiate()
			#instance.position = bottom_bun_spawn.global_position
			#instance.transform.basis = bottom_bun_spawn.global_transform.basis
			#add_child(instance)
			#print("spawned 2")
		#if grabbed_object.name == "patty_spawn":
			#instance = patty.instantiate()
			#instance.position = patty_spawn.global_position
			#instance.transform.basis = patty_spawn.global_transform.basis
			#add_child(instance)
			#print("spawned 3")
		#if grabbed_object.name == "lettuce_spawn":
			#instance = lettuce.instantiate()
			#instance.position = lettuce_spawn.global_position
			#instance.transform.basis = lettuce_spawn.global_transform.basis
			#add_child(instance)
			#print("spawned 4")

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
