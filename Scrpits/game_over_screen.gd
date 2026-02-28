extends Control

@onready var pointsTxt = $Points
@onready var sound = $AudioStreamPlayer

func die(points):
	visible = true
	pointsTxt.text = str(points)
	sound.play()
