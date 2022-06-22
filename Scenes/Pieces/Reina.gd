extends "res://Scenes/Pieces/Base.gd"

func _ready():
	# Si el tablero es 8x8, queremos ir de -7 a 7
	for i in range(-owner.tablero.size()+1,owner.tablero.size()):
		casillasDisponibles.append(Vector2(i,0))
		casillasDisponibles.append(Vector2(0,i))
	for i in range(owner.tablero.size()):
		casillasDisponibles.append(Vector2(i,i))
		casillasDisponibles.append(Vector2(-i,-i))
		casillasDisponibles.append(Vector2(i,-i))
		casillasDisponibles.append(Vector2(-i,i))
