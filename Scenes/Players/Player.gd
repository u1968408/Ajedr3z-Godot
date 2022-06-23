extends "res://Scenes/Pieces/Base.gd"
class_name Player

var fletxaPath = preload("res://Scenes/Players/Weapons/Fletxa.tscn")
var tornJugador = false

signal tornAcabat

func potJugar():
	tornJugador = true

func _unhandled_input(event):
	if tornJugador:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_RIGHT and event.pressed:
				var mouse_pos = get_global_mouse_position()
				var tile = owner.get_node('TileMap').world_to_map(mouse_pos)
				tile.y += 8
				hacerMovimiento(get_parent().get_parent().tablero,tile)
			elif event.button_index == BUTTON_LEFT and event.pressed:
				disparar()

func acabarTorn():
	emit_signal("tornAcabat")

func disparar():
	var fletxa = fletxaPath.instance()
	fletxa.global_position = $Bow/bow_sprite.global_position
	fletxa.look_at(get_global_mouse_position())
	get_parent().add_child(fletxa)
	fletxa.velocity = get_global_mouse_position() - fletxa.position
	tornJugador = false
	fletxa.connect("destroyed",self,"acabarTorn")

