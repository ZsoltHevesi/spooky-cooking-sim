extends Area3D
class_name Spawner

@onready var spawn: Area3D = $"."
@onready var spawn_mesh_3d: MeshInstance3D = $MeshInstance3D
@onready var spawn_collision_3d: CollisionShape3D = $CollisionShape3D
@export var entity : Resource ## Entity that will be instantiated by the spawner.
@export var spawn_mesh : Mesh ## The [param Mesh] resource for the spawn.
@export var unlimited : bool ## If [code]true[/code], makes the spawner unlimited. By default spawner works only once (cont. in [param spawned]).
@export var spawned : bool ## If [code]true[/code], the spawner is marked as used and will not instantiate again until [param spawned] is [code]false[/code].
@export_custom(PROPERTY_HINT_LINK, "") var mesh_scale : Vector3 = Vector3(1.0, 1.0, 1.0) ## Sets the scale value of the spawn [param Mesh].
var instance

func _ready() -> void:
	spawn_mesh_3d.scale = mesh_scale
	if spawn_mesh != null:
		spawn_mesh_3d.mesh = spawn_mesh
		spawn_collision_3d.make_convex_from_siblings()

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
