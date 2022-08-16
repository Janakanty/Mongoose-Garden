extends Control

onready var fire_mongoose = $mongooses/fire
onready var water_mongoose = $mongooses/water
onready var garden_mongoose = $mongooses/garden
onready var mongooses = $mongooses
var column = 1
var mongoose_mode = 1 # 1 - water , 2 - fire , 3 - garderer
var mongoose_is_changing = 0

var game_pause = false
var menu_active = 1

func _ready():
	$changeMongoose.play("RESET")
	$camera.play("slowMove")
	
		

func _input(event):
		change_mongoose_position()
		quit()
		change_mongoose_to_active()
		space_menu_start_game()
	
func space_menu_start_game():
	if Input.is_action_just_pressed("space"):
		$menu2.play("start_game")
		yield(get_tree().create_timer(3), "timeout")
		$TextureRect2.hide()
		menu_active = 0
		get_node("plantControl").gameplay_plan_machine()
	
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
				water_mongoose.active = false
				fire_mongoose.active = true
			2:
				mongoose_mode = 3
				$changeMongoose.play("change_to_garden")
				fire_mongoose.active = false
				garden_mongoose.active = true
			3:
				mongoose_mode = 1
				$changeMongoose.play("change_to_water")
				garden_mongoose.active = false
				water_mongoose.active = true
		pass
	
func change_mongoose_position():
	if Input.is_action_just_pressed("left") and column > 1:
		$AudioStreamPlayer2.play()
		column = column - 1
		check_mognoose_position()
	elif Input.is_action_just_pressed("right") and column < 7:
		$AudioStreamPlayer2.play()
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

func end_game():
	if Global.point >= 500:
		pass
		#win
	if Global.life <= 0:
		pass
		#false

func _on_changeMongoose_animation_finished(anim_name):
	mongoose_is_changing = 0


func _on_Button_pressed(): # znikające menu
	pass


