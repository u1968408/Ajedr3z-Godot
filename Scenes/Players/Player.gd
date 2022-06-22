extends "res://Scenes/Pieces/Base.gd"

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT and event.pressed:
			var mouse_pos = get_global_mouse_position()
			var tile = owner.get_node('TileMap').world_to_map(mouse_pos)
			tile.y += 8
			hacerMovimiento(owner.tablero,tile)
