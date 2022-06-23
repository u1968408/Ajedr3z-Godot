extends "res://Scenes/Pieces/Base.gd"
class_name Player

onready var soTir = $Disparo
var fletxaPath = preload("res://Scenes/Players/Weapons/Fletxa.tscn")
var tornJugador = false
var movido = false

signal tornAcabat

func potJugar():
	tornJugador = true
	movido = false

func _unhandled_input(event):
	if tornJugador:
		if event is InputEventMouseButton:
			if !movido and event.button_index == BUTTON_RIGHT and event.pressed:
				var mouse_pos = get_global_mouse_position()
				var tile = owner.get_node('TileMap').world_to_map(mouse_pos)
				tile.y += 8
				movido = hacerMovimiento(get_parent().get_parent().tablero,tile)
			elif event.button_index == BUTTON_LEFT and event.pressed:
				disparar()

func acabarTorn():
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	emit_signal("tornAcabat")

func disparar():
	soTir.play()
	var fletxa = fletxaPath.instance()
	fletxa.global_position = $Bow/inicio.global_position
	fletxa.look_at(get_global_mouse_position())
	get_parent().add_child(fletxa)
	fletxa.velocity = get_global_mouse_position() - fletxa.position
	tornJugador = false
	fletxa.connect("destroyed",self,"acabarTorn")

