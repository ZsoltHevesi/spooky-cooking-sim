extends CollisionObject3D
class_name Interactible

@export var reticle_text = "Interact"
@export var reticle_input = "[button]"

signal interacted(body)

func get_input():
	var key_name = ""
	for action in InputMap.action_get_events(reticle_input):
		if action is InputEventKey:
			key_name = action.as_text_physical_keycode()
			break
	return reticle_text + "\n[" + key_name + "]"

func interact(body):
	interacted.emit(body)
