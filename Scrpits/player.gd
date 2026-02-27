extends CharacterBody2D


const SPEED = 3.0
const JUMP_VELOCITY = -100.0
const SLIPPERY_INDEX = 1

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.2

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x += direction * SPEED
	elif velocity.x > 0:
		velocity.x -= SLIPPERY_INDEX
	
	if direction != 0:
		sprite.play("walk")
		sprite.flip_h = direction < 0 

	move_and_slide()
