extends "res://Scenes/Pieces/Base.gd"

var seHaMovido = false
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
			get_parent().add_child(reinaNueva)
			queue_free()
		else:
			var random = RandomNumberGenerator.new()
			random.randomize()
			var posPieza = rand_range(0,3)
			var nuevaPieza = posiblesEvoluciones[posPieza].instance()
			if posPieza != 2:
				nuevaPieza.tablero = owner.tablero
			nuevaPieza.pos = pos
			nuevaPieza.position = position
			get_parent().add_child(nuevaPieza)
			queue_free()
