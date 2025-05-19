extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var PLAYER_LOCATION: Vector2 = Vector2(22, 26)

func _ready() -> void:
	spawn()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("Jump")
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
		if is_on_floor():
			$AnimatedSprite2D.play("Run")
		if Input.is_action_pressed("left"):
			$AnimatedSprite2D.set_flip_h(true)  # Vänd åt vänster
		elif Input.is_action_pressed("right"):
			$AnimatedSprite2D.set_flip_h(false) # Vänd åt höger


	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not direction and is_on_floor():
			$AnimatedSprite2D.play("Idle")

	move_and_slide()

func _on_respawn():
	spawn()
	
func spawn():
	position = Vector2(PLAYER_LOCATION.x, PLAYER_LOCATION.y)
	
func set_player_location(new_x: float, new_y: float) -> void:
	PLAYER_LOCATION = Vector2(new_x, new_y)
