extends Node

var Piezas
var Tablero

var random = RandomNumberGenerator.new()
var nPiezas
var nMovidas = 0
var movs

signal tornAcabat

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

# Hace un movimiento y devuelve el movimiento hecho
func hacerTurno():
	movs = todosLosMovimientosPosibles()
	print(movs)
	# Miramos si en alguno de los movimientos podemos pillar al jugador
	for pieza in movs:
		var arrayMovs = pieza.movimientos[0]
		for mov in arrayMovs:
			if Tablero[mov.y][mov.x]==1:
				Piezas.find_node(pieza.name).hacerMovimiento(Tablero,mov)
				print("He ganado con la pieza ",pieza.name," y el mov ",mov)
				return true
	
	nPiezas = random.randi_range(1,2)
	print("SE VAN A MOVER ",nPiezas," PIEZAS")
	$Timer.start()
	return false

func _ready():
	random.randomize()
	Piezas = get_node("../Pieces/PiecesIA")
	Tablero = owner.tablero


func _on_Timer_timeout():
	var piezaIndex = random.randi_range(0,movs.size()-1)
	var pieza = movs[piezaIndex]
	print(pieza.name,": ",pieza.movimientos[0])
	var rand_index = random.randi() % pieza.movimientos[0].size()
	Piezas.find_node(pieza.name).hacerMovimiento(Tablero,pieza.movimientos[0][rand_index])
	movs.remove(piezaIndex)
	nMovidas += 1
	if nMovidas == nPiezas:
		emit_signal("tornAcabat")
		$Timer.stop()
		nMovidas = 0
	else:
		$Timer.start()
