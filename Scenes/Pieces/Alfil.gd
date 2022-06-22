extends "res://Scenes/Pieces/Base.gd"

func _ready():
	casillasDisponibles = []
	# Si el tablero es 8x8, queremos ir de -7 a 7
	for i in range(owner.tablero.size()):
		casillasDisponibles.append(Vector2(i,i))
		casillasDisponibles.append(Vector2(-i,-i))
		casillasDisponibles.append(Vector2(i,-i))
		casillasDisponibles.append(Vector2(-i,i))
