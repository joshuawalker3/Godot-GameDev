extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		
		if is_on_floor() and $AnimatedSprite2D.animation == "Idle":
			$AnimatedSprite2D.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if $AnimatedSprite2D.is_playing() and $AnimatedSprite2D.animation == "Run" and velocity.x == 0:
		$AnimatedSprite2D.stop()
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("Jump")
	
	if Input.is_action_just_pressed("attack"):
		$AnimatedSprite2D.play("Attack1")
		
	if not $AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("Idle")

	move_and_slide()
