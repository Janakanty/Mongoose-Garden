extends Control

onready var mongooses = $mongooses
var column = 1
var mongoose_mode = 1 # 1 - water , 2 - fire , 3 - garderer
var mongoose_is_changing = 0

func _ready():
	pass # Replace with function body.

func _input(event):
	change_mongoose_position()
	quit()
	change_mongoose_to_active()
	
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
	if Input.is_action_just_pressed("up") and mongoose_is_changing == 0 :
		mongoose_is_changing = 1
		match mongoose_mode:
			1:
				mongoose_mode = 2
				$changeMongoose.play("change_to_fire")
			2:
				mongoose_mode = 3
				$changeMongoose.play("change_to_garden")
			3:
				mongoose_mode = 1
				$changeMongoose.play("change_to_water")
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


func _on_changeMongoose_animation_finished(anim_name):
	mongoose_is_changing = 0


func _on_Button_pressed(): # znikające menu
	pass
