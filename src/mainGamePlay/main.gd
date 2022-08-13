extends Node2D

func _ready():
	pass # Replace with function body.

func _input(event):
	quit()
	
func quit():
	if Input.is_action_pressed("quit"):
		get_tree().quit()
