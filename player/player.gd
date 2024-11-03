extends Node3D

@export var MOUSE_SENSITIVITY : float = 0.35
@export var DEFAULT_SPEED : float = 5.0
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA_CONTROLLER : Camera3D

var _mouse_input : bool = false
var _rotation_input : float
var _tilt_input : float


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event.is_action_pressed("exit"):
		$"../".exit_game(name.to_int())
		get_tree().quit()

func _unhandled_input(event):
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY


func _process(delta: float) -> void:
	pass
