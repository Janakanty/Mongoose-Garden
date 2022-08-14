extends Control

var active: bool = false
var column = 1
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
	check_column_from_parent()
	
	
func powerOFF():
	$power.play_backwards("powerON")
	Global.evaporating_col1 = 0
	Global.evaporating_col2 = 0
	Global.evaporating_col3 = 0
	Global.evaporating_col4 = 0
	Global.evaporating_col5 = 0
	Global.evaporating_col6 = 0
	Global.evaporating_col7 = 0

func check_column_from_parent():
	column = get_parent().get_parent().column
	match column:
		1:
			Global.evaporating_col1 = 1
		2:
			Global.evaporating_col2 = 1
		3:
			Global.evaporating_col3 = 1
		4:
			Global.evaporating_col4 = 1
		5:
			Global.evaporating_col5 = 1
		6:
			Global.evaporating_col6 = 1
		7:
			Global.evaporating_col7 = 1
