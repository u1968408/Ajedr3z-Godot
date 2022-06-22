extends Sprite

onready var velocidad = rand_range(0.05,0.1)

func _ready():
	scale *= rand_range(0.5,1.2)

func _process(delta):
	position.x += 0.05
