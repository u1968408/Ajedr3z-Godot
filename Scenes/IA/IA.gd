extends Node

var Piezas
var Player
var Tablero

# Array con todos los movimientos que pueda hacer la IA
func todosLosMovimientosPosibles():
	var res = []
	for pieza in Piezas.get_children():
		var piezaMovimientos = {
			'name': pieza.name,
			'movimientos': []
		}
		piezaMovimientos['movimientos'].append(pieza.posiblesMovimientos(Tablero))
		res.append(piezaMovimientos)
	return res

func hacerMovimiento(pieza,movimiento):
	var movs = todosLosMovimientosPosibles()
	# Si se puede hacer el movimiento (redundante?)
	#if movimiento in movs and movs[movimiento].name == pieza and movs[movimiento].movimientos.has(movimiento):
	pieza.hacerMovimiento(Tablero,movimiento)

func _ready():
	Piezas = get_node("../Pieces/PiecesIA")
	Player = get_node("../Pieces/Player")
	Tablero = owner.tablero
	#for mov in todosLosMovimientosPosibles():
	#	print(mov.name, ": ",mov.movimientos)
