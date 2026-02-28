extends CharacterBody2D

const SPEED = 3.0
const JUMP_VELOCITY = -100.0
const SLIPPERY_INDEX = 2

@onready var sprite = $AnimatedSprite2D
@onready var inventory = %Inventory
@onready var map = %Map
@onready var bp = %Inventory/BlockPicker

var oxygen = float(100.0)

var playerInside := false

func _input(event: InputEvent) -> void:
	if event.is_action("Place1"):
		bp.set_cell(Vector2i(1, 4), 1, Vector2i(0,0))
		bp.erase_cell(Vector2i(1, 5))
		bp.erase_cell(Vector2i(1, 6))
		map.setCurrentBlockPlace(Vector2i(0,0))
	
	if event.is_action("Place2"):
		bp.set_cell(Vector2i(1, 5), 1, Vector2i(0,0))
		bp.erase_cell(Vector2i(1, 4))
		bp.erase_cell(Vector2i(1, 6))
		map.setCurrentBlockPlace(Vector2i(1,0))
		
	if event.is_action("Place3"):
		bp.set_cell(Vector2i(1, 6), 1, Vector2i(0,0))
		bp.erase_cell(Vector2i(1, 4))
		bp.erase_cell(Vector2i(1, 5))
		map.setCurrentBlockPlace(Vector2i(2,0))

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
	else:
		velocity.x = 0
		
	if direction != 0:
		sprite.play("walk")
		sprite.flip_h = direction < 0 
	else:
		sprite.stop()
		
	
	if playerInside and oxygen <= 100.0:
		oxygen += 0.2
	else:
		oxygen -= 0.02
	inventory.updateO2(oxygen)

	move_and_slide()
