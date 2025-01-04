extends Node3D
@onready var customer_spawn: Spawner = $customer_spawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	customer_spawn.spawn_new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
