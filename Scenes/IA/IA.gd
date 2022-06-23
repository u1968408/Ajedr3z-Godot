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
	for pieza in get_parent().find_node("PiecesIA").get_children():
		var piezaMovimientos = {
			'name': pieza.name,
			'movimientos': [],
			'atacar': true
		}
		var movsPosibles = pieza.posiblesMovimientos(Tablero)
		if !movsPosibles.empty():
			piezaMovimientos['movimientos']=movsPosibles
			if pieza.name.begins_with("Peo") and !pieza.puedeAtacar:
				piezaMovimientos.atacar = false
			res.append(piezaMovimientos)
	return res

# Hace un movimiento y devuelve el movimiento hecho
func hacerTurno():
	movs = todosLosMovimientosPosibles()
	# Miramos si en alguno de los movimientos podemos pillar al jugador
	for pieza in movs:
		var arrayMovs = pieza.movimientos
		for mov in arrayMovs:
			if Tablero[mov.y][mov.x]==1 and pieza.atacar:
				Piezas.get_node(pieza.name).hacerMovimiento(Tablero,mov)
				print("He ganado con la pieza ",pieza.name," y el mov ",mov)
				return true
	
	nPiezas = random.randi_range(1,movs.size())
	if nPiezas > 3:
		nPiezas = 3
	$Timer.start()
	return false

func _ready():
	random.randomize()
	Piezas = get_parent().find_node("PiecesIA")
	Tablero = owner.tablero


func _on_Timer_timeout():
	Piezas = get_parent().find_node("PiecesIA")
	if movs.size() != 0:
		var piezaIndex = random.randi_range(0,movs.size()-1)
		var pieza = movs[piezaIndex]
		var rand_index = random.randi() % pieza.movimientos.size()
		Piezas.get_node(pieza.name).hacerMovimiento(Tablero,pieza.movimientos[rand_index])
		movs.remove(piezaIndex)
		nMovidas += 1
		if nMovidas == nPiezas:
			emit_signal("tornAcabat")
			$Timer.stop()
			nMovidas = 0
		else:
			$Timer.start()
	else:
		emit_signal("tornAcabat")
		$Timer.stop()
		nMovidas = 0
