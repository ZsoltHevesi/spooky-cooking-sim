extends CharacterBody3D

@export var MOUSE_SENSITIVITY : float = 0.35
@export var DEFAULT_SPEED : float = 5.0
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA_CONTROLLER : Camera3D

var _mouse_input : bool = false
var _mouse_rotation : Vector3
var _rotation_input : float
var _player_rotation : Vector3
var _camera_rotation : Vector3
var _tilt_input : float
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var _speed : float


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_speed = DEFAULT_SPEED

func _input(event):
	#for testing and development ESC is quitting the game, will be changed later
	if event.is_action_pressed("exit"):
		get_tree().quit()

func _unhandled_input(event):
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY

func _update_camera(delta):
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0, _mouse_rotation.y, 0.0)
	_camera_rotation = Vector3(_mouse_rotation.x, 0.0, 0.0)
	
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	CAMERA_CONTROLLER.rotation.z = 0.0
	
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	_rotation_input = 0.0
	_tilt_input = 0.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	_update_camera(delta)

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * _speed
			velocity.z = direction.z * _speed
		else:	
			velocity.x = lerp(velocity.x, direction.x * _speed, delta * 14.0)
			velocity.z = lerp(velocity.z, direction.z * _speed, delta * 14.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * _speed, delta * 3.25)
		velocity.z = lerp(velocity.z, direction.z * _speed, delta * 3.25)

	move_and_slide()
