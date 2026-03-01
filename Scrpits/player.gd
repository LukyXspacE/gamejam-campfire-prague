extends CharacterBody2D

#Subsurface Extraction

const SPEED = 3.0
const JUMP_VELOCITY = -100.0
const SLIPPERY_INDEX = 2

@onready var sprite = $AnimatedSprite2D
@onready var inventory = %Inventory
@onready var map = %Map
@onready var bp = %Inventory/BlockPicker
@onready var gameOver = $Cam/GameOverScreen
@onready var cam = $Cam
@onready var sun = %DirectionalLight

var oxygen = float(100.0)
var oxygenLimit = 100.0

var playerInside := false

var isDead = false

var startFallY = position.y
var isFaling = false

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

func canPlace() -> bool:
	if inventory.iron > 0:
		return true
	else:
		return false

func place(value):
	inventory.iron -= value
	inventory.syncText()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not isDead:
		velocity += get_gravity() * delta * 0.18
		isFaling = true

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor() and not isDead:
		velocity.y = JUMP_VELOCITY
		startFallY = position.y

	var direction := Input.get_axis("Left", "Right")
	if direction and not isDead:
		velocity.x += direction * SPEED	
	else:
		velocity.x = 0
		
	if direction != 0:
		sprite.play("walk")
		sprite.flip_h = direction < 0 
	else:
		sprite.stop()
		
	
	if playerInside and oxygen <= oxygenLimit:
		oxygen += 0.2
	else:
		oxygen -= 0.02
	inventory.updateO2(oxygen)
	
	if Input.is_action_pressed("Smelt") and playerInside:
		inventory.smelt()
	
	if Input.is_action_pressed("Sell") and playerInside:
		inventory.sell()
	
	if oxygen <= 0 or (abs(position.y - startFallY) > 160 and isFaling and is_on_floor()):
		gameOver.die(inventory.money)
		isDead = true
		cam.zoom.x = 1.0
		cam.zoom.y = 1.0
		sun.enabled = false
		
	if is_on_floor(): 
		startFallY = position.y
		isFaling = false
		
	if inventory.ironRaw < -40 or Input.is_action_just_pressed("ui_down"):
		gameOver.die(inventory.money)
		isDead = true
		cam.zoom.x = 1.0
		cam.zoom.y = 1.0
		sun.enabled = false
	
	if Input.is_action_just_pressed("Upgrade") and playerInside == true and inventory.money >= 50:
		inventory.o2bar.max_value = 200
		inventory.money -= 50
		oxygenLimit += 100
	
	move_and_slide()
