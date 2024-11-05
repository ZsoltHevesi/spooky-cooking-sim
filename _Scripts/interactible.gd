extends CollisionObject3D
class_name Interactible

@export var reticle_text = "Interact"

func interact(body):
	print(body.name, " interacted with ", name)
