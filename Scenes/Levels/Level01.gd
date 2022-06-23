extends Node2D

var tornJugador = false #false: blancas, true: negras

var Peo = preload("res://Scenes/Pieces/Peo.tscn")
var posInicial = Vector2(8,4)
var tablero = [
	[0, 0, 2, 0, 0, 0, 2, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 2, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 2, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 1, 0, 0, 0, 0],
]

# Crea una hilera de peones al final del tablero
func debugPeones():
	var x = posInicial.x
	var y = posInicial.y
	for i in range(8):
		var nouPeo = Peo.instance()
		nouPeo.position.x = x
		nouPeo.position.y = y
		x += posInicial.x
		y += posInicial.y
		nouPeo.pos = Vector2(7,i)
		$Pieces.add_child(nouPeo)
		tablero[7][i] = 2

# Called when the node enters the scene tree for the first time.
func quitarPieza(pieza):
	print ("jeje uno menos", pieza.pos)
	print(pieza)
	print(tablero)
	tablero[pieza.pos.x][pieza.pos.y] = 0
	print(tablero)

func _ready():
	for pieza in $Pieces/PiecesIA.get_children():
		pieza.connect("pieceDestroyed", self, "quitarPieza")
	if $IA.hacerTurno():
		print("GAME_OVER")

func _process(delta):
	# Si el jugador le da al espacio y quiere pasar turno sin disparar
	if Input.is_action_just_pressed("pasaTurno") and tornJugador:
		tornJugador = false
		if $IA.hacerTurno():
			print("GAME_OVER")

# Al disparar
func _on_Player_tornAcabat():
	tornJugador = false
	if $IA.hacerTurno():
		print("GAME_OVER")


func _on_IA_tornAcabat():
	tornJugador = true
	$Pieces/Player.potJugar()
