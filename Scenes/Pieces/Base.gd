extends Node2D

export var casillasDisponibles = [] # Vector2(1,1)...
export var blanca = -1
export var pos = Vector2(-1,-1)

func _ready():
	assert( !casillasDisponibles.empty(), "ERROR: Las casillas disponibles no pueden estar vacias!")
	assert( blanca == 1 or blanca == 2, "ERROR: O es blanca o es negra, decidete bro.")
	assert( pos.x>=0 and pos.y>=0, "ERROR: Bro que posicion es esta?????")
	

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state

# Devuelve un array de los posibles movimientos que puede hacer la pieza
func posiblesMovimientos(tablero):
	var res = []
	for casilla in casillasDisponibles:
		var casillaResultante = Vector2(pos.x+casilla.x,pos.y+casilla.y)
		if casillaResultante.x >= 0 and casillaResultante.x < tablero.size() and casillaResultante.y >= 0 and casillaResultante.y < tablero[casillaResultante.x].size() and tablero[casillaResultante.x][casillaResultante.y]==0:
			res.append(casillaResultante)
	return res
	
# Devuelve true si el movimiento se puede hacer
func comprobarMovimiento(tablero, movimiento):
	return movimiento in posiblesMovimientos(tablero)

# Si el movimiento es plausible, lo realiza
func hacerMovimiento(tablero, movimiento):
	if comprobarMovimiento(tablero,movimiento):
		tablero[pos.x][pos.y] = 0
		tablero[movimiento.x][movimiento.y] = blanca
		pos = movimiento
		


func _on_Pieza_mouse_entered():
	$Sprite.modulate.a = 0.6


func _on_Pieza_mouse_exited():
	$Sprite.modulate.a = 1
