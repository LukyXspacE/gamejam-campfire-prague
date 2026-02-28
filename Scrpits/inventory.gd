extends Node2D

@onready var cam = %Cam
const OFFSET = Vector2(-73, -41)

@onready var uranTxt = $LabelUran
@onready var ironTxt = $LabelIronCoocke
@onready var ironRawTxt = $LabeIronRaw

var uranium = 0
var ironRaw = 0
var iron = 0

func addResource(id):
	if id == 1:
		iron += 1
		ironTxt.text = str(iron)
	if id == 2:
		uranium += 1
		uranTxt.text = str(uranium)
	if id == 3:
		ironRaw += 1
		ironRawTxt.text = str(ironRaw)

func _process(delta: float) -> void:
	global_position = cam.get_screen_center_position() + OFFSET
