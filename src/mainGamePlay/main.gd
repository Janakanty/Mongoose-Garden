extends Control

onready var fire_mongoose = $mongooses/fire
onready var water_mongoose = $mongooses/water
onready var garden_mongoose = $mongooses/garden
onready var mongooses = $mongooses
onready var tween = get_node("Tween")

var column = 1               # kolumna na której aktualnie jest mangusta
var mongoose_mode = 1        # 1 - water , 2 - fire , 3 - garderer
var mongoose_is_changing = 0 # zmienna nie pozwalająca uruchomić kolejnej animacji jeżeli aktualna się jeszcze nie skoczyła.  
var menu_hide = 0
var position_x_column_array = [231, 474, 717, 960, 1203, 1446, 1689]


func _ready():
		$changeMongoose.play("RESET") #reset pozycji mangust. Czasem źle się ustawiają. 
		$camera.play("slowMove")      # efekt kamery na pocztku rozgrywki


func _unhandled_input(_event):
		change_mongoose_position()
		change_mongoose_to_active()
		quit()


func _input(_event):
		space_menu_start_game()


# FUNKCJE STERUJĄCE


func change_mongoose_position(): #zmiana pozycji mangust
		if Input.is_action_just_pressed("left") and column > 1:
				$changeColumnSound.play()
				column = column - 1
				check_mognoose_position()
		elif Input.is_action_just_pressed("right") and column < 7:
				$changeColumnSound.play()
				column = column + 1
				check_mognoose_position()


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


func space_menu_start_game():
		if Input.is_action_just_pressed("space") and menu_hide == 0:
				$menu_anim.play("menu_hide")
				menu_hide = 1


func quit():
		if Input.is_action_pressed("quit"):
				get_tree().quit()


func check_mognoose_position():
		tween.interpolate_property($mongooses, "rect_global_position", null, Vector2(position_x_column_array[column-1],0), 0.3, Tween.TRANS_SINE,Tween.EASE_IN_OUT)
		tween.start()

#FUNKCJE 

func end_game():
		if Global.point >= 500:
				pass
				#win
		if Global.life <= 0:
				pass
				#false


func _on_changeMongoose_animation_finished(_anim_name):
		mongoose_is_changing = 0

