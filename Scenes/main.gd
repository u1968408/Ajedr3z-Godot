extends Node2D

func _ready():
	pass

func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level01.tscn")


func _on_Quit_pressed():
	get_tree().quit()
