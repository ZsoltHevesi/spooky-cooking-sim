extends RayCast3D

func _physics_process(delta):
	if is_colliding():
		if Input.is_action_just_released("interact"):
			if get_collider().is_in_group("stove"):
				get_collider().use()
