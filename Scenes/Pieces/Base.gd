extends Node2D

export var casillasDisponibles = [] # Vector2(1,1)...
export var blanca = true

func _ready():
	pass # Replace with function body.

func comprobarMovimiento(tablero):
	for casilla in casillasDisponibles:
		
