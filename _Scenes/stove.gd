extends Interactible
@onready var camera_3d: Camera3D = $Camera3D
@onready var stove_menu: Control = $stove_menu
@onready var stove: StaticBody3D = $"."

var top_bun = load("res://_Scenes/burger_top_bun.tscn")
var top_bun_instance



func _on_interacted(body: Variant) -> void:
	camera_3d.current = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	stove_menu.visible = true
	get_node("../player").hud.visible = false

func _on_button_pressed() -> void:
	top_bun_instance = top_bun.instantiate()
	top_bun_instance.position = stove.position
	top_bun_instance.position.y = 0.6
	top_bun_instance.transform.basis = stove.transform.basis
	stove.add_child(top_bun_instance)
