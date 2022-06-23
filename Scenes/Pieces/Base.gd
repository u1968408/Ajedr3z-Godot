extends Node2D

export var casillasDisponibles = [] # Vector2(1,1)...
export var blanca = -1
export var pos = Vector2(-1,-1)

signal pieceDestroyed

func _ready():
	pass
	#assert( pos.x>=0 and pos.y>=0, "ERROR: Bro que posicion es esta?????")

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state

# Devuelve un array de los posibles movimientos que puede hacer la pieza
func posiblesMovimientos(tablero):
	var res = []
	for casilla in casillasDisponibles:
		var casillaResultante = Vector2(pos.x+casilla.x,pos.y+casilla.y)
		#print(name," voy a mirar si es valido ",casillaResultante," siendo mis posibilidades ",casillasDisponibles," y mi pos ",pos)
		if casillaResultante.y >= 0 and casillaResultante.y < tablero.size() and casillaResultante.x >= 0 and casillaResultante.x < tablero[casillaResultante.y].size() and (tablero[casillaResultante.y][casillaResultante.x]==0 or tablero[casillaResultante.y][casillaResultante.x]==1):
			res.append(casillaResultante)
			
	return res
	
# Devuelve true si el movimiento se puede hacer
func comprobarMovimiento(tablero, movimiento):
	return movimiento in posiblesMovimientos(tablero)

# Calcula el vector que hay que sumarle a la posicion global
func calculaPixels(vectorMov):
	# Calculo del movimiento (si no fuera en isometrico.............)
	var vectorResultante = Vector2(0,0)
	# -1,-1 2,2 ... diagonal decreciente
	if vectorMov.x==vectorMov.y:
		vectorResultante = Vector2(vectorMov.x*0,vectorMov.y*8)
	elif abs(vectorMov.x)==abs(vectorMov.y):
		vectorResultante = Vector2(vectorMov.x*16,vectorMov.y*0)
	elif vectorMov.x==0:
		vectorResultante = Vector2(vectorMov.y*-8,vectorMov.y*4)
	elif vectorMov.y==0:
		vectorResultante = Vector2(vectorMov.x*8,vectorMov.x*4)
	else:
		# Solo el caballo se puede mover así
		# Seguro que hay una forma muchisimo mas eficiente de hacer esto
		if vectorMov == Vector2(-2,-1):
			vectorResultante = Vector2(vectorMov.x-8,vectorMov.y-12)
		elif vectorMov == Vector2(-2,-1):
			vectorResultante = Vector2(vectorMov.x+8,vectorMov.y-12)
		elif vectorMov == Vector2(2,1):
			vectorResultante = Vector2(vectorMov.x+8,vectorMov.y+12)
		elif vectorMov == Vector2(1,2):
			vectorResultante = Vector2(vectorMov.x-8,vectorMov.y+12)
		elif vectorMov == Vector2(1,-2):
			vectorResultante = Vector2(vectorMov.x+24,vectorMov.y-4)
		elif vectorMov == Vector2(2,-1):
			vectorResultante = Vector2(vectorMov.x+24,vectorMov.y+4)
		elif vectorMov == Vector2(-2,1):
			vectorResultante = Vector2(vectorMov.x-24,vectorMov.y-4)
		elif vectorMov == Vector2(-1,2):
			vectorResultante = Vector2(vectorMov.x-24,vectorMov.y+4)
		else:
			assert("MOVIMIENTO IMPOSIBLE?")
			
		# No sé por qué no cuadra
		vectorResultante.x -= vectorMov.x
		vectorResultante.y -= vectorMov.y
	return vectorResultante

# Si el movimiento es plausible, lo realiza.
# Movimiento es la casilla a la que nos queremos mover
func hacerMovimiento(tablero, movimiento):
	if comprobarMovimiento(tablero,movimiento):
		tablero[pos.y][pos.x] = 0
		tablero[movimiento.y][movimiento.x] = blanca
		
		#Actually mover la pieza
		var vectorMov = Vector2((movimiento.x-pos.x),(movimiento.y-pos.y))
		
		var vectorResultante = calculaPixels(vectorMov)
		
		pos = movimiento
		
		position.x += vectorResultante.x
		position.y += vectorResultante.y
		return true
	else:
		print("no se puede hacer este movimiento: ",movimiento,", lista de movs: ",posiblesMovimientos(tablero))
		return false


func _on_Pieza_mouse_entered():
	$Sprite.modulate.a = 0.6


func _on_Pieza_mouse_exited():
	$Sprite.modulate.a = 1


func _on_Pieza_body_entered(body):
	if body is Fletxa and blanca == 2:
		emit_signal("pieceDestroyed", self)
		
		queue_free()
		body.emit_signal("destroyed")
		body.queue_free()
