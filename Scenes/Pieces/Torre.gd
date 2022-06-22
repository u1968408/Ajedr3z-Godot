extends "res://Scenes/Pieces/Base.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Si el tablero es 8x8, queremos ir de -7 a 7
	for i in range(-owner.tablero.size()+1,owner.tablero.size()):
		casillasDisponibles.append(Vector2(i,0))
		casillasDisponibles.append(Vector2(0,i))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
