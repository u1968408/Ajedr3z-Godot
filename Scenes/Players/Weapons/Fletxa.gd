extends KinematicBody2D
class_name Fletxa

var velocity = Vector2(0, 0)
var speed = 150

signal destroyed

func _ready():
	pass 

func _physics_process(delta):
	move_and_collide(velocity.normalized() * delta * speed)


func _on_Timer_timeout(): # Eliminem la fletxa passat un temps
	emit_signal("destroyed")
	queue_free()
