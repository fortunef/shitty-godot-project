extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var DOUBLE_JUMP_VELOCITY = -400.0
@export var acceleration : int = 50
@export var wallJump = 1000

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hasDashed : bool = false
var hasDoubleJumped : bool = false
var isWallSliding : bool = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY # Everything under here handles double jumping
		hasDoubleJumped = false
	else:
		if Input.is_action_just_pressed("Jump") and hasDoubleJumped == false and not is_on_floor():
			velocity.y = DOUBLE_JUMP_VELOCITY
			hasDoubleJumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED - acceleration
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("Shift") and velocity.x > 0 and hasDashed == false:
		velocity.x = 2000.0
		hasDashed = true
		print("Dash Right")
	elif Input.is_action_just_pressed("Shift") and velocity.x < 0 and hasDashed == false:
		velocity.x = -2000.0
		hasDashed = true
		print("Dash Left")
	if Input.is_action_just_pressed("Shift") and velocity.y > 0 and hasDashed == false:
		velocity.y = 500.0
		hasDashed = true
		print("Dash Down")
	elif Input.is_action_just_pressed("Shift") and velocity.y < 0 and hasDashed == false:
		velocity.y = -500.0
		hasDashed = true
		print("Dash Up")

	if is_on_floor():
		hasDashed = false
	
	if is_on_wall() and Input.is_action_pressed("Right") and Input.is_action_pressed("Jump"):
		velocity.y = -400
		velocity.x -= wallJump
		hasDoubleJumped = false
	if is_on_wall() and Input.is_action_pressed("Left") and Input.is_action_pressed("Jump"):
		velocity.y = -400
		velocity.x = wallJump
		hasDoubleJumped = false
		
	move_and_slide()
