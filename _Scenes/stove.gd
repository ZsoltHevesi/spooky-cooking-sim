extends Interactible
@onready var camera_3d: Camera3D = $Camera3D



func _on_interacted(body: Variant) -> void:
	camera_3d.current = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_node("../player").hud.visible = false
	
