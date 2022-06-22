extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Peo = preload("res://Scenes/Pieces/Peo.tscn")
var Peons = []
var posInicial = Vector2(8,4)
var tablero = [
	[0, 0, 0, 0, 2, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 2, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 1, 0, 0, 0, 0],
]

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var mouse_pos = get_global_mouse_position()
			var tile = get_node('TileMap').world_to_map(mouse_pos)
			tile.y += 8
			$Pieces/PiecesIA/Peo.hacerMovimiento(tablero,tile)
			

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
		Peons.append(nouPeo)
		tablero[7][i] = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
