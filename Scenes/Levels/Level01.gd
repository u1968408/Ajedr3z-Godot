extends Node2D

var tornJugador = false #false: blancas, true: negras
var guanyat = false
var nTorns = 0
var nEnemics = 0
var Peo = preload("res://Scenes/Pieces/Peo.tscn")
var posInicial = Vector2(8,4)

onready var GUI = $GUI
onready var PiecesIA = $Pieces/PiecesIA
var tablero = [
	[2, 0, 0, 0, 2, 0, 2, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
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

func quitarPieza(pieza):
	tablero[pieza.pos.y][pieza.pos.x] = 0
	pieza.queue_free()
	nEnemics -= 1
	GUI.actualitzarEnemics(nEnemics)
	if nEnemics==0:
		GUI.guanyat()
		guanyat = true

func turnoIA():
	if !guanyat:
		GUI.tornCPU()
		tornJugador = false
		if $IA.hacerTurno():
			GUI.perdut()
			$Pieces/Player.queue_free()

func _ready():
	for pieza in $Pieces/PiecesIA.get_children():
		pieza.connect("pieceDestroyed", self, "quitarPieza")
	nEnemics = PiecesIA.get_child_count()
	GUI.actualitzarEnemics(nEnemics)
	turnoIA()

func _process(delta):
	# Si el jugador le da al espacio y quiere pasar turno sin disparar
	if !guanyat and Input.is_action_just_pressed("pasaTurno") and tornJugador:
		_on_Player_tornAcabat()
		

# Acaba el turno del jugador
func _on_Player_tornAcabat():
	nTorns+=1
	GUI.actualitzarTorns(nTorns)
	turnoIA()

# Turno del jugador
func _on_IA_tornAcabat():
	tornJugador = true
	GUI.tornJUG()
	$Pieces/Player.potJugar()
