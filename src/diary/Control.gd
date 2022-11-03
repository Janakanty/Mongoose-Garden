extends Node2D

func _input(_event):
	if Input.is_action_just_pressed("space") and Global.notes_showed == false and Global.start_gameplay == true :
		show()
		Global.notes_showed = true
		get_parent().pause_game()
	elif Input.is_action_just_pressed("space") and Global.notes_showed == true:
		hide()
		Global.notes_showed = false
		if Global.pause_by_p == false:
				get_parent().pause_game()
				
	if Input.is_action_just_pressed("left") and Global.notes_showed == true:
		$TextureRect2.hide()
		$TextureRect.show()
	elif Input.is_action_just_pressed("right") and Global.notes_showed == true:
		$TextureRect2.show()
		$TextureRect.hide()
