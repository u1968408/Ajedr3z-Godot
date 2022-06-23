extends Node2D

var _smoothed_mouse_pos: Vector2


func _ready():
	pass 


func _process(delta):
	_smoothed_mouse_pos = lerp(_smoothed_mouse_pos, get_global_mouse_position(), 0.8)
	look_at(_smoothed_mouse_pos)
