extends Control

var active: bool = false
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
	Global.evaporating_col1 = 0
	Global.evaporating_col2 = 0
	Global.evaporating_col3 = 0
	Global.evaporating_col4 = 0
	Global.evaporating_col5 = 0
	Global.evaporating_col6 = 0
	Global.evaporating_col7 = 0
	
func powerOFF():
	$power.play_backwards("powerON")
