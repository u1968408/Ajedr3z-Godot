extends "res://Scenes/Pieces/Base.gd"

var Reina = preload("res://Scenes/Pieces/Reina.tscn")
var Torre = preload("res://Scenes/Pieces/Torre.tscn")
var Alfil = preload("res://Scenes/Pieces/Alfil.tscn")
var Caballo = preload("res://Scenes/Pieces/Caballo.tscn")

var posiblesEvoluciones = [Torre, Alfil, Caballo]

signal convertido

var seHaMovido = false
var puedeAtacar = false
		
func hacerMovimiento(tablero, movimiento):
	if casillasDisponibles[0]!=Vector2(0,1):
		if tablero[movimiento.y][movimiento.x]!=1:
			casillasDisponibles[0]=Vector2(0,1)
			movimiento=pos+Vector2(0,1)
	elif casillasDisponibles[0]==Vector2(0,1) and tablero[movimiento.y][movimiento.x]==0:
		.hacerMovimiento(tablero,movimiento)
	if !seHaMovido:
		casillasDisponibles.pop_back()
		seHaMovido = true
	print(tablero)
	print("Tamaño del tablero: ",tablero.size()-1, "Posicion: ",pos.y)
	if pos.y == tablero.size()-1:
		if get_parent().find_node("Reina") == null:
			var reinaNueva = Reina.instance()
			reinaNueva.tablero = owner.tablero
			reinaNueva.pos = pos
			reinaNueva.position = position
			reinaNueva.name = "Reina"
			reinaNueva.owner = self.owner
			get_parent().add_child(reinaNueva)
			queue_free()
			emit_signal("convertido", reinaNueva)
		else:
			var random = RandomNumberGenerator.new()
			random.randomize()
			var posPieza = random.randi_range(0,3)
			var nuevaPieza = posiblesEvoluciones[posPieza].instance()
			if posPieza != 2:
				nuevaPieza.tablero = owner.tablero
			nuevaPieza.pos = pos
			nuevaPieza.position = position
			nuevaPieza.owner = self.owner
			get_parent().add_child(nuevaPieza)
			queue_free()
			emit_signal("convertido", nuevaPieza)
	else:
		if pos.y >= 0 and pos.y < tablero.size():
			if pos.x-1 >= 0 and pos.x-1 < tablero.size() and tablero[pos.y+1][pos.x-1]==1:
				casillasDisponibles.clear()
				casillasDisponibles.append(Vector2(-1,1))
				print("izq")
				puedeAtacar = true
			elif pos.x+1 >= 0 and pos.x+1 < tablero.size() and tablero[pos.y+1][pos.x+1]==1:
				casillasDisponibles.clear()
				casillasDisponibles.append(Vector2(1,1))
				print("der")
				puedeAtacar = true
			else:
				casillasDisponibles.clear()
				casillasDisponibles.append(Vector2(0,1))
				puedeAtacar = false
