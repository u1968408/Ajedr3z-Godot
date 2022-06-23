extends Node2D

onready var CPU = $GUI_CPU
onready var JUG = $GUI_JUG

func _ready():
	CPU.visible = false
	JUG.visible = false


func actualitzarTorns(nTorns):
	$GUI_General/Torns.text = str(nTorns)

func actualitzarEnemics(nEnemics):
	$GUI_General/EnemicsRest.text = str(nEnemics)

func tornJUG():
	CPU.visible = false
	JUG.visible = true

func tornCPU():
	CPU.visible = true
	JUG.visible = false
