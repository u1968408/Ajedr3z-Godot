extends Node

var Piezas
var Player
var Tablero

var random = RandomNumberGenerator.new()
var nPiezas
var nMovidas = 0

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
	var movs = todosLosMovimientosPosibles()
	# Miramos si en alguno de los movimientos podemos pillar al jugador
	for pieza in movs:
		var arrayMovs = pieza.movimientos[0]
		for mov in arrayMovs:
			if Tablero[mov.x][mov.y]==1:
				Piezas.find_node(pieza.name).hacerMovimiento(Tablero,mov)
				Player.queue_free()
				return true
	
	random.randomize()
	nPiezas = random.randi_range(1,3)
	$Timer.start()

func _ready():
	random.randomize()
	Piezas = get_node("../Pieces/PiecesIA")
	Player = get_node("../Pieces/Player")
	Tablero = owner.tablero


func _on_Timer_timeout():
	var movs = todosLosMovimientosPosibles()	
	var piezaIndex = random.randi_range(0,movs.size()-1)
	var pieza = movs[piezaIndex]
	print(pieza.name,": ",pieza.movimientos[0])
	var rand_index = random.randi() % pieza.movimientos[0].size()
	Piezas.find_node(pieza.name).hacerMovimiento(Tablero,pieza.movimientos[0][rand_index])
	movs.remove(piezaIndex)
	nMovidas += 1
	if nMovidas == nPiezas:
		emit_signal("tornAcabat")
	else:
		$Timer.start()
