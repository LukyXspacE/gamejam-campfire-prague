extends Control

@onready var pointsTxt = $Points

func die(points):
	visible = true
	pointsTxt.text = str(points)
