extends TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Mine"):
		var mouse_pos = get_local_mouse_position()       # mouse relative to TileMap
		var cell = local_to_map(mouse_pos)              # convert to tile coordinates
		erase_cell(cell)                 # remove the tile
	
	if event.is_action_pressed("Build"):
		var mouse_pos = get_local_mouse_position()
		var cell = local_to_map(mouse_pos)
		if get_cell_source_id(cell) == -1:
			set_cell(cell, 1, Vector2i(0,0))
