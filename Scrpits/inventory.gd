extends Node2D

@onready var cam = %Cam
const OFFSET = Vector2(-96, -54)


@onready var o2bar = $Bar

@onready var uranTxt = $LabelUran
@onready var ironTxt = $LabelIronCoocke
@onready var ironRawTxt = $LabeIronRaw
@onready var rockTxt = $LabelRock
@onready var monetTxt = $LabelBitcoin

var uranium = 0
var ironRaw = 0
var iron = 99
var rock = 0
var money = 0

func updateO2(value):
	o2bar.value = value

func addResource(id):
	if id == 0:
		rock += 1
		rockTxt.text = str(rock)
	if id == 1:
		iron += 1
		ironTxt.text = str(iron)
	if id == 2:
		uranium += 1
		uranTxt.text = str(uranium)
	if id == 4:
		ironRaw += 1
		ironRawTxt.text = str(ironRaw)

func syncText():
	rockTxt.text = str(rock)
	ironTxt.text = str(iron)
	uranTxt.text = str(uranium)
	ironRawTxt.text = str(ironRaw)
	monetTxt.text = str(money)

func smelt():
	var ammount = min(uranium, ironRaw)
	
	for i in ammount:
		uranium -= 1
		ironRaw -= 1
		syncText()
		iron += 2
		syncText()
		i += 1

func sell():
	
	var i = 0
	
	#while i < 10 and iron > 0:
		#iron -= 1 #100
		#money += 1
		#syncText()
		#i += 1
		
	while i < 10 and rock > 0:
		rock -= 1 #1
		money += 1
		syncText()
		i += 1
	
	syncText()

func _ready() -> void:
	addResource(1)

func _process(delta: float) -> void:
	global_position = cam.get_screen_center_position() + OFFSET
