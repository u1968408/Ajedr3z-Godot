extends "res://Scenes/Pieces/Base.gd"

var tablero

func _ready():
	casillasDisponibles = []
	if owner != null:
		tablero = owner.tablero
	# Si el tablero es 8x8, queremos ir de -7 a 7
	for i in range(-tablero.size()+1,tablero.size()):
		casillasDisponibles.append(Vector2(i,0))
		casillasDisponibles.append(Vector2(0,i))

