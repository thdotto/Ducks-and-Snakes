extends CharacterBody3D


@onready var camera : Camera3D = $Camera
@onready var s_b_00 : SpringBoneSimulator3D = $"Armature/Skeleton/Spring Bone 00"

var SPEED         : float = 0.00
var JUMP_VELOCITY : float = 4.50

var direction : Vector3 = Vector3(0, 0, 0)
var input_dir : Vector2 = Vector2(0, 0)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("space_key") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if input_dir != Vector2(0.0, 0.0):
		SPEED = lerp(SPEED, 4.00, delta * 10.00)
	else:
		SPEED = lerp(SPEED, 0.00, delta * 10.00)

	input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0.00, input_dir.y)).normalized(), delta * 10.00)

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
