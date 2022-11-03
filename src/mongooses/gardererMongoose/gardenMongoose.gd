extends Control

var active: bool = false

func _ready():
		$pows.z_index = 1



func _input(_event):
		power_if_active()


func power_if_active():
		if active == true and Global.pause == false:
				if Input.is_action_just_pressed("down"):
						powerON()
				elif Input.is_action_just_released("down"):
						powerOFF()


func powerON():
		$power.play("powerON")
		$AudioStreamPlayer.play()
		Global.mongoose_active = true


func powerOFF():
		$power.play_backwards("powerON")
		Global.mongoose_active = false


func pause_mongoose():
		if active == true:
				Global.mongoose_active = false
				$power.stop()


func loose_mongoose():
		if active == true:
				Global.mongoose_active = true
				$power.play("RESET")


func _on_Area2D_area_entered(area):
		if area.is_in_group("plant"):
				area.get_parent().taken_off_the_board()
