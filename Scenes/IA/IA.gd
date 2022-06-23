extends Node

var Piezas
var Player
var Tablero

var random = RandomNumberGenerator.new()


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
	var nPiezas = random.randi_range(1,3)
	print(nPiezas)
	# Moveremos nPiezas, entre 1 y 3
	for i in range(nPiezas):
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		var piezaIndex = random.randi_range(0,movs.size()-1)
		var pieza = movs[piezaIndex]
		var rand_index = random.randi() % pieza.movimientos[0].size()
		Piezas.find_node(pieza.name).hacerMovimiento(Tablero,pieza.movimientos[0][rand_index])
		movs.remove(piezaIndex)
	return false

func _ready():
	random.randomize()

	Piezas = get_node("../Pieces/PiecesIA")
	Player = get_node("../Pieces/Player")
	Tablero = owner.tablero
	#for mov in todosLosMovimientosPosibles():
	#	print(mov.name, ": ",mov.movimientos)
