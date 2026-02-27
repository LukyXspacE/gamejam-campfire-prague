extends Node2D

const MOUSESPEED = 500.0

func _process(delta: float) -> void:
	var pos = global_position
	get_viewport().warp_mouse(pos)
