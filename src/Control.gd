extends Control

var showed = 0

func _input(_event):
	if Input.is_action_just_pressed("space") and showed == 0 and Global.start_gameplay == true:
		show()
		showed = 1
	elif Input.is_action_just_pressed("space") and showed == 1:
		hide()
		showed = 0
	if Input.is_action_just_pressed("left") and showed == 1:
		$TextureRect2.hide()
		$TextureRect.show()
	elif Input.is_action_just_pressed("right") and showed == 1:
		$TextureRect2.show()
		$TextureRect.hide()
