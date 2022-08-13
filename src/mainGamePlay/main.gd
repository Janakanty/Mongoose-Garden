extends Control

onready var mongooses = $mongooses
var column = 1

func _ready():
	pass # Replace with function body.

func _input(event):
	change_mongoose_position()
	quit()
	
func quit():
	if Input.is_action_pressed("quit"):
		get_tree().quit()

func start_game():
	pass

func stat_gameplay():
	pass
	
func mongoose_control():
	pass
	
func change_mongoose_to_active():
	pass
	
func change_mongoose_position():
	if Input.is_action_just_pressed("left") and column > 1:
		column = column - 1
		check_mognoose_position()
	elif Input.is_action_just_pressed("right") and column < 7:
		column = column + 1
		check_mognoose_position()

func check_mognoose_position():
	match column:
		1:
			mongooses.rect_position.x = 231
		2:
			mongooses.rect_position.x = 474
		3:
			mongooses.rect_position.x = 717
		4:
			mongooses.rect_position.x = 960
		5:
			mongooses.rect_position.x = 1203
		6:
			mongooses.rect_position.x = 1446
		7:
			mongooses.rect_position.x = 1689
	print(column)
