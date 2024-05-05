extends CharacterBody3D


@export var SPEED = 5.0
@export var JUMP_VELOCITY = 0
@export var Player_Reach = 1.5
@export var Mouse_Lock_State: bool = true
@export var Mouse_Sensitivity = 0.01
@onready var Neck := $"Camera Holder"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	print_debug("Player is ready")
	MouseLock(Mouse_Lock_State)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x * Mouse_Sensitivity)
		Neck.rotate_x(-event.relative.y * Mouse_Sensitivity)
	
	Neck.rotation_degrees.x = clamp(Neck.rotation_degrees.x, -89, 89)

func _physics_process(delta):
	
	#do controller look
	var controller_look = Input.get_vector("Look_Left", "Look_Right", "Look_Up", "Look_Down")
	self.rotation.y -= (controller_look.x * (Mouse_Sensitivity * 10))
	Neck.rotation.x -= (controller_look.y * (Mouse_Sensitivity * 10))
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Foward", "Back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func MouseLock(LockState: bool):
	if LockState == true:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	else: if LockState == false:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	

func TeleportPlayer (TP_Position: Vector3, View_Rotation: Vector2):
	print_debug("Teleporting player to " + str(TP_Position) + str(View_Rotation))
	self.Position = TP_Position
	self.Rotation.y = View_Rotation.y
	Neck.rotation.x = clamp(View_Rotation, -89, 89)
