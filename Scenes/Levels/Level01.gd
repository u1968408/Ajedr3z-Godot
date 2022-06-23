extends "res://Scenes/Levels/LevelBase.gd"

func _init():
	tablero = [
		[2, 0, 0, 0, 2, 0, 2, 0],
		[0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 1, 0, 0, 0, 0],
	]
func generarPitch():
	pitch = float(nTorns)/10
	if pitch < 1:
		return 1 + pitch
	else:
		return 2
