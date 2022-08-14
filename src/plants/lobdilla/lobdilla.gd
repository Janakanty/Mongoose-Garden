extends Control

onready var tween = get_node("Tween")

#zmienne rośliny
onready var regres_bar = $regres
onready var progres_bar =$progres
onready var timer_down = $Timer_to_lose
var my_column = 0 #kolumna w którejjest roślina
var have_i_grown_up = 0 
var plant_level = 0 #poziom rośliny 0,1,2
var plant_condition = 2 #stan rośliny
var time_down = 5.0 # czas w którym roślina zdycha
var ready = 0 #czy jest gotowa do wzicia 0 - nie, 1 - tak
var my_x_position 


func _ready():
	timer_down.wait_time = time_down
	my_x_position = rect_position.x

func _process(delta):
	lose_way()
	grow_way(delta)


func grow_way(delta):
	#każda roślina ma swój specjalny grow way
	match my_column:
		1:
			if Global.watering_col1 == 1:
				progres_bar.value += 10 * delta
				reset_condition()
		2:
			if Global.watering_col2 == 1:
				progres_bar.value += 10 * delta
				reset_condition()
		3:
			if Global.watering_col3 == 1:
				progres_bar.value += 10 * delta
				reset_condition()
		4:
			if Global.watering_col4 == 1:
				progres_bar.value += 10 * delta
				reset_condition()
		5:
			if Global.watering_col5 == 1:
				progres_bar.value += 10 * delta
				reset_condition()
		6:
			if Global.watering_col6 == 1:
				progres_bar.value += 10 * delta
				reset_condition()
		7:
			if Global.watering_col7 == 1:
				progres_bar.value += 10 * delta
				reset_condition()

func lose_way():
	regres_bar.value = timer_down.time_left
	regres_bar.show()

func check_plant_condition():
	#roślina zdycha
	if plant_condition <= 0 and plant_level == 0: #jeśli roślina jest sadzonką i zdecha
		timer_down.stop()
		to_small_plant_DEAD()
	elif plant_condition <= 0 and plant_level == 1:
		timer_down.stop()
		to_plant_DEAD()
	elif plant_condition <= 0 and plant_level == 2:
		timer_down.stop()
		to_plant_DEAD()
	#roślina staje się zdechła
	elif plant_condition == 1 and plant_level == 0:
		to_small_plant_BAD()
	elif plant_condition == 1 and plant_level == 1:
		to_plant_BAD()
	elif plant_condition == 1 and plant_level == 2:
		to_plant_BAD()
	#roślina staje się OK
	elif plant_condition == 2 and plant_level == 0:
		to_small_plant_OK()
	elif plant_condition == 2 and plant_level == 1:
		to_plant_OK()
	#roślina staje się ready
	elif plant_condition == 2 and plant_level == 2:
		to_plant_READY()

		
func to_small_plant_OK():
	$smallPlantBAD.hide()
	$smallPlantOK.show()
	
func to_small_plant_BAD():
	$smallPlantOK.hide()
	$smallPlantBAD.show()
	
func to_small_plant_DEAD():
	$smallPlantBAD.hide()
	$smallPlantDEAD.show()
	
func to_plant_OK():
	$smallPlantOK.hide()
	$plantOK.show()
	
func to_plant_BAD():
	$plantOK.hide()
	$plantREADY.hide()
	$plantBAD.show()
	ready = 0
	
func to_plant_DEAD():
	$plantBAD.hide()
	$plantDEAD.show()
	
func to_plant_READY():
	$plantOK.hide()
	$plantREADY.show()
	ready = 1

func taken_off_the_board():
	if ready == 1:
		Global.point += 1
		tween.interpolate_property($".","rect_global_position", null, Vector2(my_x_position,-1000),0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		#tutaj zrobić aktualne punkty
		
	

func reset_condition():
	timer_down.start()

func _on_Timer_to_lose_timeout():
	plant_condition = plant_condition - 1 
	check_plant_condition()


func _on_progres_value_changed(value):
	regres_bar.hide()
	if progres_bar.max_value == value:
		if plant_condition == 1:
			plant_condition = plant_condition + 1
		elif plant_level == 0:
			plant_level = 1
		elif plant_level == 1:
			plant_level = 2
		progres_bar.value = 0
		check_plant_condition()


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
