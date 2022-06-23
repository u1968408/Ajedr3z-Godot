extends KinematicBody2D

var velocity = Vector2(0, 0)
var speed = 150

func _ready():
	pass 

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)


func _on_Timer_timeout(): # Eliminem la fletxa passat un temps
	queue_free()
