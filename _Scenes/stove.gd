extends Interactible
@onready var camera_3d: Camera3D = $Camera3D
@onready var stove: StaticBody3D = $"."

var top_bun = load("res://_Scenes/burger_top_bun.tscn")
var top_bun_instance
var is_in_use : bool = false

func _ready() -> void:
	set_physics_process(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RMB") and is_in_use:
		camera_3d.current = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_node("../player").hud.visible = true
		set_physics_process(false)

func _on_interacted(body: Variant) -> void:
	if !is_in_use:
		camera_3d.current = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_node("../player").hud.visible = false
		is_in_use = true
		set_physics_process(true)

func _physics_process(delta: float) -> void:
	print("STOVE")
	#top_bun_instance = top_bun.instantiate()
	#top_bun_instance.position = stove.position
	#top_bun_instance.position.y = 0.6
	#top_bun_instance.transform.basis = stove.transform.basis
	#stove.add_child(top_bun_instance)
