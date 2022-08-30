extends Control

var showed = 1

func _input(_event):
	if Input.is_action_just_pressed("space") and showed == 0:
		show()
		showed = 1
	elif Input.is_action_just_pressed("space") and showed == 1:
		hide()
		showed = 0
	if Input.is_action_just_pressed("left"):
		$TextureRect2.hide()
		$TextureRect.show()
	elif Input.is_action_just_pressed("right"):
		$TextureRect2.show()
		$TextureRect.hide()