extends RayCast3D
@onready var hud: Control = $"../../../HUD"

func _physics_process(delta):
	hud.reticle_text.text = ""
	if is_colliding():
		if get_collider() is Interactible:
			hud.reticle_text.text = get_collider().get_input()
			if Input.is_action_just_pressed(get_collider().reticle_input):
				get_collider().interact(owner)
