extends TileMapLayer

@onready var player = %Player
@onready var ray = player.get_node("RayCast2D")

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Mine"):
		var mouse_pos = get_local_mouse_position()
		var cell = local_to_map(mouse_pos)
		
		var data = get_cell_source_id(cell)
		player.addResource(data)
		
		erase_cell(cell)
	
	if event.is_action_pressed("Build"):
		var mouse_pos = get_local_mouse_position()
		var cell = local_to_map(mouse_pos)
		if get_cell_source_id(cell) == -1:
			set_cell(cell, 1, Vector2i(0,0))
