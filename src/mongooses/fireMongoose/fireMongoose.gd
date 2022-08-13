extends Control

var active: bool = true

func _ready():
	pass # Replace with function body.

func _input(event):
	power_if_active()

func power_if_active():
	if active == true:
		if Input.is_action_just_pressed("down"):
			powerON()
		elif Input.is_action_just_released("down"):
			powerOFF()
		
func powerON():
	$power.play("powerON")
	
func powerOFF():
	$power.play_backwards("powerON")
