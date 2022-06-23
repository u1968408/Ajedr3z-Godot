extends Node2D

onready var CPU = $GUI_CPU
onready var JUG = $GUI_JUG
onready var GUANYA = $GUANYAT
onready var PERD = $PERDUT

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

func guanyat():
	CPU.visible = false
	JUG.visible = false
	GUANYA.visible = true
	
func perdut():
	CPU.visible = false
	JUG.visible = false
	PERD.visible = true
	

func _on_MainMenu_pressed():
	get_tree().change_scene("res://Scenes/main.tscn")


func _on_Seguent_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level02.tscn")
