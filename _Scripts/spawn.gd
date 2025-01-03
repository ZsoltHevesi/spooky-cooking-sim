extends Area3D
class_name Spawner

@onready var spawn: Area3D = $"."

var instance
@export var entity : Resource

@export var unlimited : bool
@export var spawned : bool

func spawn_new() -> void:
	if !unlimited and !spawned:
			instance = entity.instantiate()
			instance.position = spawn.global_position
			instance.transform.basis = spawn.global_transform.basis
			get_parent().add_child(instance)
			spawned = true
	elif unlimited:
			instance = entity.instantiate()
			instance.position = spawn.global_position
			instance.transform.basis = spawn.global_transform.basis
			get_parent().add_child(instance)
			spawned = true
	else:
		print("\n#####\n", "Failed to spawn ", entity, "!\nSpawner name: ", spawn.get_name(), "\nSpawned value? ", spawned, "\nUnlimited? ", unlimited, "\n#####\n")
