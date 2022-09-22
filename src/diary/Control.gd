extends Control

func _input(_event):
	if Input.is_action_just_pressed("space") and Global.notes_showed == false and Global.start_gameplay == true:
		show()
		Global.notes_showed = true
	elif Input.is_action_just_pressed("space") and Global.notes_showed == true:
		hide()
		Global.notes_showed = false
	if Input.is_action_just_pressed("left") and Global.notes_showed == true:
		$TextureRect2.hide()
		$TextureRect.show()
	elif Input.is_action_just_pressed("right") and Global.notes_showed == true:
		$TextureRect2.show()
		$TextureRect.hide()
