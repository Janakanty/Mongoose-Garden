extends Control

var active: bool = true
var column: int = 1

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
	$ColorRect/Particles2D.emitting = true
	$AudioStreamPlayer.play()
	
func powerOFF():
	$power.stop()
	$AudioStreamPlayer.stop()
	$ColorRect/Particles2D.emitting = false
	Global.watering_col1 = 0
	Global.watering_col2 = 0
	Global.watering_col3 = 0
	Global.watering_col4 = 0
	Global.watering_col5 = 0
	Global.watering_col6 = 0
	Global.watering_col7 = 0

func check_column_from_parent(): 
	column = get_parent().get_parent().column
	match column:
		1:
			Global.watering_col1 = 1
		2:
			Global.watering_col2 = 1
		3:
			Global.watering_col3 = 1
		4:
			Global.watering_col4 = 1
		5:
			Global.watering_col5 = 1
		6:
			Global.watering_col6 = 1
		7:
			Global.watering_col7 = 1
		
