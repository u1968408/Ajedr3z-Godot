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
	$GUANYAT/Victory.play()
	CPU.visible = false
	JUG.visible = false
	if get_tree().current_scene.name != "Level04":
		GUANYA.visible = true
	else:
		$PERDUT/Guanyat.text = "El rei Shirogane I es mort"
		PERD.visible = true
	
func perdut():
	$PERDUT/Guanyat.text = "DERROTA"
	CPU.visible = false
	JUG.visible = false
	PERD.visible = true
	

func _on_MainMenu_pressed():
	get_tree().change_scene("res://Scenes/main.tscn")


func _on_Seguent_pressed():
	var nom = get_tree().current_scene.name
	nom[nom.length()-1] = str(int(nom[nom.length()-1])+1)
	get_tree().change_scene("res://Scenes/Levels/"+nom+".tscn")
