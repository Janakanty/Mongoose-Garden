extends Control

var active: bool = false
var column = 1

func _input(_event):
		power_if_active()


func power_if_active():
		if active == true and Global.pause == false:
				if Input.is_action_just_pressed("down"):
						powerON()
				elif Input.is_action_just_released("down"):
						powerOFF()


func powerON():
		Global.mongoose_active = true
		$power.play("powerON")
		$power2.play("powerON2")
		check_column_from_parent()
		get_parent().get_node("water").get_node("power").play("powerON")
		get_parent().get_node("water").get_node("ColorRect").get_node("Particles2D").emitting = true
		$AudioStreamPlayer.play()


func powerOFF():
		get_parent().get_node("water").get_node("power").stop()
		get_parent().get_node("water").get_node("ColorRect").get_node("Particles2D").emitting = false
		$power.play_backwards("powerON")
		$power2.stop()
		$AudioStreamPlayer.stop()
		Global.mongoose_active = false
		powerOFF_plant()

func pause_mongoose():
		$power.stop()
		$power2.stop()
		$AudioStreamPlayer.stop()
		Global.mongoose_active = false
		powerOFF_plant()


func loose_mongoose():
		if active ==true:
				get_parent().get_node("water").get_node("power").stop()
				get_parent().get_node("water").get_node("ColorRect").get_node("Particles2D").emitting = false
				$power.play_backwards("powerON")
				$power2.play()
				$AudioStreamPlayer.stop()
				Global.mongoose_active = false
				powerOFF_plant()

func powerOFF_plant():
		Global.evaporating_col1 = 0
		Global.evaporating_col2 = 0
		Global.evaporating_col3 = 0
		Global.evaporating_col4 = 0
		Global.evaporating_col5 = 0
		Global.evaporating_col6 = 0
		Global.evaporating_col7 = 0


func check_column_from_parent():
		if Global.mongoose_active == true and active == true:
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
