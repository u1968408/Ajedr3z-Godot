extends "res://Scenes/Pieces/Base.gd"

export var seHaMovido = false
var Reina = preload("res://Scenes/Pieces/Reina.tscn")
var Torre = preload("res://Scenes/Pieces/Torre.tscn")
var Alfil = preload("res://Scenes/Pieces/Alfil.tscn")
var Caballo = preload("res://Scenes/Pieces/Caballo.tscn")

var posiblesEvoluciones = [Torre, Alfil, Caballo]

func hacerMovimiento(tablero, movimiento):
	.hacerMovimiento(tablero,movimiento)
	if !seHaMovido:
		casillasDisponibles.pop_back()
		seHaMovido = true
	if pos.y == 7:
		if get_parent().find_node("Reina") == null:
			var reinaNueva = Reina.instance()
			reinaNueva.tablero = owner.tablero
			reinaNueva.pos = pos
			reinaNueva.position = position
			reinaNueva.name = "Reina"
			get_parent().add_child(reinaNueva)
			queue_free()
		else:
			var random = RandomNumberGenerator.new()
			random.randomize()
			var posPieza = random.randi_range(0,3)
			var nuevaPieza = posiblesEvoluciones[posPieza].instance()
			if posPieza != 2:
				nuevaPieza.tablero = owner.tablero
			nuevaPieza.pos = pos
			nuevaPieza.position = position
			get_parent().add_child(nuevaPieza)
			queue_free()
	else:
		print(pos," ",tablero[pos.y+1][pos.x-1])
		if pos.y >= 0 and pos.y < tablero.size():
			if pos.x-1 >= 0 and pos.x-1 < tablero.size() and tablero[pos.x-1][pos.y+1]==1:
				casillasDisponibles.append(Vector2(-1,1))
			elif pos.x+1 >= 0 and pos.x+1 < tablero.size() and tablero[pos.x+1][pos.y+1]==1:
				casillasDisponibles.append(Vector2(1,1))
