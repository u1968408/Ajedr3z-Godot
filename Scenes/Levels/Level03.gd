extends "res://Scenes/Levels/Level01.gd"

func _ready():
	tablero = [
		[0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
		[-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1],
		[-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1],
		[-1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1],
		[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1],
		[-1, -1, -1, -1, -1, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1],
		[-1, -1, -1, -1, -1, -1, 0, 0, 0, -1, -1, -1, -1, -1, -1],
		[-1, -1, -1, -1, -1, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1],
		[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1],
		[-1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1],
		[-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1],
		[-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1],
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	]