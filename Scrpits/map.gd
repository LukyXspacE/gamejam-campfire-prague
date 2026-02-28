extends TileMapLayer

@onready var player = %Player
@onready var  inventory = %Player/Cam/Inventory

var currentBlockPlace = Vector2i(0, 0)

func setCurrentBlockPlace(value):
	currentBlockPlace = value

func updateBlocks(pos):
	var upBlockCord = Vector2(pos.x +1, pos.y)
	var downBlockCord = Vector2(pos.x -1, pos.y)
	var leftBlockCord = Vector2(pos.x, pos.y -1)
	var rightBlockCord = Vector2(pos.x, pos.y +1)
	
	var list = [upBlockCord, downBlockCord, leftBlockCord, rightBlockCord]
	
	var i = 0
	while i < 4:
		var sidesFull = [false, false, false, false]
		
		var upCord = Vector2(list[i].x, list[i].y -1)
		var downCord = Vector2(list[i].x, list[i].y +1)
		var leftCord = Vector2(list[i].x -1, list[i].y)
		var rightCord = Vector2(list[i].x +1, list[i].y)
		
		if get_cell_source_id(upCord) != -1:
			sidesFull[0] = true
		if get_cell_source_id(downCord) != -1:
			sidesFull[1] = true
		if get_cell_source_id(leftCord) != -1:
			sidesFull[2] = true
		if get_cell_source_id(rightCord) != -1:
			sidesFull[3] = true
		
		var layer = get_cell_source_id(list[i])
		
		if layer != 1:
		
			if sidesFull == [false, false, false, false] :
				set_cell(list[i], layer, Vector2i(0, 3))
			
			if sidesFull == [true, false, false, false]:
				set_cell(list[i], layer, Vector2i(3, 0))
			if sidesFull == [false, true, false, false]:
				set_cell(list[i], layer, Vector2i(3, 3))
			if sidesFull == [false, false, true, false]:
				set_cell(list[i], layer, Vector2i(3, 2))
			if sidesFull == [false, false, false, true]:
				set_cell(list[i], layer, Vector2i(3, 1))
			
			if sidesFull == [true, true, false, false]:
				set_cell(list[i], layer, Vector2i(1, 3))
			if sidesFull == [true, false, true, false]:
				set_cell(list[i], layer, Vector2i(2, 2))
			if sidesFull == [true, false, false, true]:
				set_cell(list[i], layer, Vector2i(0, 2))
			
			if sidesFull == [false, true, true, false]:
				set_cell(list[i], layer, Vector2i(2, 0))
			if sidesFull == [false, true, false, true]:
				set_cell(list[i], layer, Vector2i(0, 0))
			
			if sidesFull == [true, true, true, false]:
				set_cell(list[i], layer, Vector2i(2, 1))
			if sidesFull == [true, true, false, true]:
				set_cell(list[i], layer, Vector2i(0, 1))
				
			if sidesFull == [true, false, true, true]:
				set_cell(list[i], layer, Vector2i(1, 2))
			if sidesFull == [false, true, true, true]:
				set_cell(list[i], layer, Vector2i(1, 0))
				
			if sidesFull == [false, false, true, true]:
				set_cell(list[i], layer, Vector2i(2, 3))
			if sidesFull == [true, true, true, true]:
				set_cell(list[i], layer, Vector2i(1, 1))
		
		i += 1

func addResource(id):
	if id == 0:
		inventory.rock += 1
		inventory.rockTxt.text = str(inventory.rock)
	if id == 1:
		inventory.iron += 1
		inventory.ironTxt.text = str(inventory.iron)
	if id == 2:
		inventory.uranium += 1
		inventory.uranTxt.text = str(inventory.uranium)
	if id == 4:
		inventory.ironRaw += 1
		inventory.ironRawTxt.text = str(inventory.ironRaw)

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Mine"):
		var mouse_pos = get_local_mouse_position()
		var cell = local_to_map(mouse_pos)
		
		var data = get_cell_source_id(cell)
		
		addResource(data)
		
		if get_cell_source_id(cell) != 5 or 6:
			erase_cell(cell)
			if get_cell_source_id(cell) != 1:
				updateBlocks(cell)
	
	if event.is_action_pressed("Build"):
		var mouse_pos = get_local_mouse_position()
		var cell = local_to_map(mouse_pos)
		if get_cell_source_id(cell) == -1:
			set_cell(cell, 1, currentBlockPlace)
