extends RayCast3D

func _physics_process(delta):
	if is_colliding():
		if get_collider() is Node:
			if get_collider().is_in_group("stove"):
				print("STOVE TOUCHER")
				if Input.is_action_just_released("interact"):
					get_collider().use()
