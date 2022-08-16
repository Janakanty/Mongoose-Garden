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
	$AudioStreamPlayer.play()
	
func powerOFF():
	$power.play_backwards("powerON")


func _on_Area2D_area_entered(area):
	if area.is_in_group("plant"):
		area.get_parent().taken_off_the_board()
