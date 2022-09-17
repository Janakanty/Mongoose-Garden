extends Control

onready var tween = get_node("Tween")

#zmienne rośliny
onready var progres_bar = $textures/progres
onready var regres_bar = $textures/regres
onready var timer_down = $Timer_to_lose
var my_column = 0                          # kolumna w której jest roślina
var plant_level = 0                        # poziom rośliny 1,1,2
var plant_condition = 2                    # stan rośliny
var time_down = 15.0                       # czas w którym roślina zdycha
var ready = false                          # czy jest gotowa do wzicia 1 - nie, 1 - tak
var dead = false
var point = 0 
var mode = 0                               # 1 - water mode 1 - steam
var my_x_position 
var added_condition = 0
var name_plant 



func _ready():
	#testy
	timer_down.wait_time = time_down
	my_x_position = rect_position.x
	timer_down.start()
	change_mode()	


func _process(delta):
		lose_way()
		grow_way(delta)


func grow_way(delta): 
		#każda roślina ma swój specjalny grow way
		if mode == 0: 
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
		elif mode == 1:	
				match my_column:
					1:
						if Global.evaporating_col1 == 1:
							progres_bar.value += 10 * delta
							reset_condition()
					2:
						if Global.evaporating_col2 == 1:
							progres_bar.value += 10 * delta
							reset_condition()
					3:
						if Global.evaporating_col3 == 1:
							progres_bar.value += 10 * delta
							reset_condition()
					4:
						if Global.evaporating_col4 == 1:
							progres_bar.value += 10 * delta
							reset_condition()
					5:
						if Global.evaporating_col5 == 1:
							progres_bar.value += 10 * delta
							reset_condition()
					6:
						if Global.evaporating_col6 == 1:
							progres_bar.value += 10 * delta
							reset_condition()
					7:
						if Global.evaporating_col7 == 1:
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
		$textures/smallPlantBAD.hide()
		$textures/smallPlantOK.show()
	
func to_small_plant_BAD():
		$textures/smallPlantOK.hide()
		$textures/smallPlantBAD.show()
	
func to_small_plant_DEAD():
		$textures/smallPlantBAD.hide()
		$textures/smallPlantDEAD.show()
		if plant_condition == 0:
				dead = true
	
func to_plant_OK():
		$textures/smallPlantOK.hide()
		$textures/plantOK.show()
	
func to_plant_BAD():
		$textures/plantOK.hide()
		$textures/plantREADY.hide()
		$textures/plantBAD.show()
		ready = false
	
func to_plant_DEAD():
		$textures/plantBAD.hide()
		$textures/plantDEAD.show()
		if plant_condition == 0:
				dead = true
	
func to_plant_READY():
		$textures/plantOK.hide()
		$textures/plantREADY.show()
		ready = true

func taken_off_the_board():
		if ready == true or dead == true:
				if ready == true:
						get_point()
						#fajny dźwięk
				tween.interpolate_property($".","rect_global_position", null, Vector2(my_x_position,-1000),0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()
				#tutaj zrobić aktualne punkty


func reset_condition():
		timer_down.start()


func get_point():
		Global.point += point
		Global.refresh_point()


# INDIVIDUAL PLANTS 
# Kod rośliny składa się z:
# -  ustawienia początkowych wartości tj. ustawienie tekstur, nazwy, ile punktów da do puli jeśli gracz ją zrealizuje, czas regresu i czas postępu. 
# -  rozwoju rośliny 
# -  właściwości specjalnych


func LOBDILLA(): # LOAD CZY PRELOAD? OTO JEST PTANIE
		name_plant = "LOBDILLA"
		point = 1
		time_down = 5
		rect_position.y = rect_position.y - 50
		$textures/progres.max_value = 30
		$textures/regres.max_value = 5
		$textures/regres.value = 5
		$textures/progres.rect_position.y += 20
		$textures/regres.rect_position.y += 20
		$textures/flowerPot.texture = load("res://graphics/plants/lobdilla/lobdilla doniczka.png")
		$textures/smallPlantOK.texture = load("res://graphics/plants/lobdilla/LOBDILLA sadzonka OK.png")
		$textures/smallPlantBAD.texture = load("res://graphics/plants/lobdilla/LOBDILLA sadzonka BAD.png")
		$textures/smallPlantDEAD.texture = load("res://graphics/plants/lobdilla/LOBDILLA sadzonka DEAD.png")
		$textures/plantOK.texture = load("res://graphics/plants/lobdilla/LOBDILLA OK.png")
		$textures/plantBAD.texture = load("res://graphics/plants/lobdilla/LOBDILLA BAD.png")
		$textures/plantDEAD.texture = load("res://graphics/plants/lobdilla/LOBDILLA DEAD.png")
		$textures/plantREADY.texture = load("res://graphics/plants/lobdilla/LOBDILLA OK.png")

func progress_max_value_LOBDILLA(_value):
		if plant_condition == 1:
				plant_condition = plant_condition + 1
		elif plant_level == 0:
				plant_level = 1
		elif plant_level == 1:
				plant_level = 2
		progres_bar.value = 0


func BLEEDI():
		name_plant = "BLEEDI"
		point = 1
		time_down = 10
		rect_position.y = rect_position.y + 9
		$textures/progres.max_value = 20
		$textures/regres.max_value = 10
		$textures/regres.value = 10
		$textures/progres.rect_position.y -= 20
		$textures/regres.rect_position.y -= 20
		$textures/progres.rect_position.x += 5
		$textures/regres.rect_position.x += 5
		$textures/flowerPot.texture = load("res://graphics/plants/bleedi/bleedi doniczka.png")
		$textures/smallPlantOK.texture = load("res://graphics/plants/bleedi/BLEEDI sadzonka OK.png")
		$textures/smallPlantBAD.texture = load("res://graphics/plants/bleedi/BLEEDI sadzonka BAD.png")
		$textures/smallPlantDEAD.texture = load("res://graphics/plants/bleedi/BLEEDI sadzonka DEAD.png")
		$textures/plantOK.texture = load("res://graphics/plants/bleedi/BLEEDI OK.png")
		$textures/plantBAD.texture = load("res://graphics/plants/bleedi/BLEEDI BAD.png")
		$textures/plantDEAD.texture = load("res://graphics/plants/bleedi/BLEEDI DEAD.png")
		$textures/plantREADY.texture = load("res://graphics/plants/bleedi/BLEEDI OK.png")

func progress_max_value_BLEEDI(_value):
		if plant_condition == 1:
			plant_condition = plant_condition + 1
		elif plant_level == 0:
			plant_level = 1
		elif plant_level == 1 and added_condition == 0:
			added_condition = 1
		elif plant_level == 1 and added_condition == 1:
			plant_level = 2
		progres_bar.value = 0


func VIOLIK():
		name_plant = "VIOLIK"
		point = 1
		time_down = 20
		mode = 1
		$textures/progres.max_value = 40
		$textures/regres.max_value = 20
		$textures/regres.value = 20
		$textures.rect_position.x -= 30
		$textures/progres.rect_position.y -= 20
		$textures/regres.rect_position.y -= 20
		$textures/progres.rect_position.x += 35
		$textures/regres.rect_position.x += 35
		$textures/flowerPot.texture = load("res://graphics/plants/violik/doniczka.png")
		$textures/smallPlantOK.texture = load("res://graphics/plants/violik/VIOLIK sadzonka OK.png")
		$textures/smallPlantBAD.texture = load("res://graphics/plants/violik/VIOLIK sadzonka BAD.png")
		$textures/smallPlantDEAD.texture = load("res://graphics/plants/violik/VIOLIK sadzonka DEAD.png")
		$textures/plantOK.texture = load("res://graphics/plants/violik/VIOLIK OK.png")
		$textures/plantBAD.texture = load("res://graphics/plants/violik/VIOLIK BAD.png")
		$textures/plantDEAD.texture = load("res://graphics/plants/violik/VIOLIK DEAD.png")
		$textures/plantREADY.texture = load("res://graphics/plants/violik/VIOLIK OK.png")

func progress_max_value_VIOLIK(_value):
		if plant_condition == 1:
			plant_condition = plant_condition + 1
		elif plant_level == 0:
			plant_level = 1
		elif plant_level == 1 and added_condition == 0:
			added_condition = 1
		elif plant_level == 1 and added_condition == 1:
			plant_level = 2
		progres_bar.value = 0


func NEEDLI():
		name_plant = "NEEDLI"
		point = 1
		time_down = 25
		rect_position.y = rect_position.y - 34
		$textures/progres.max_value = 30
		$textures/regres.max_value = 25
		$textures/progres.rect_position.y += 25
		$textures/regres.rect_position.y += 25
		$textures/progres.rect_position.x += 17
		$textures/regres.rect_position.x += 17
		$textures/flowerPot.texture = load("res://graphics/plants/needli/needli doniczka.png")
		$textures/smallPlantOK.texture = load("res://graphics/plants/needli/NEEDLI sadzonka OK.png")
		$textures/smallPlantBAD.texture = load("res://graphics/plants/needli/NEEDLI sadzonka BAD.png")
		$textures/smallPlantDEAD.texture = load("res://graphics/plants/needli/NEEDLI sadzonka DEAD.png")
		$textures/plantOK.texture = load("res://graphics/plants/needli/NEEDLI OK.png")
		$textures/plantBAD.texture = load("res://graphics/plants/needli/NEEDLI BAD.png")
		$textures/plantDEAD.texture = load("res://graphics/plants/needli/NEEDLI DEAD.png")
		$textures/plantREADY.texture = load("res://graphics/plants/needli/NEEDLI OK.png")

func progress_max_value_NEEDLI(_value):
		if plant_condition == 1:
				plant_condition = plant_condition + 1
		elif plant_level == 0:
				plant_level = 1
				added_condition = 1
		elif plant_level == 1 and added_condition == 1:
				added_condition = 2
				change_mode()
		elif plant_level == 1 and added_condition == 2:
				added_condition = 3
				change_mode()
		elif plant_level == 1 and added_condition == 3:
				added_condition = 4
				change_mode()
		elif plant_level == 1 and added_condition == 4:
				plant_level = 2
		progres_bar.value = 0
		change_mode()


func change_mode():
	if added_condition < 2 and name_plant != "VIOLIK": #water mode
		mode = 0
		$textures/regres.tint_progress = Color("506bfb") #Color(0.24,0.32,0.85)
	else: 
		mode = 1
		$textures/regres.tint_progress = Color("fb5050") # Color(0.91,0.27,0.27,1.0)
	


func BLUMLIT():
		name_plant = "BLUMLIT"
		point = 1
		time_down = 15
		$textures/progres.max_value = 30
		$textures/regres.max_value = 15
		$textures/regres.value = 15
		$textures/flowerPot.texture = load("res://graphics/plants/blumlit/blumlit doniczka.png")
		$textures/smallPlantOK.texture = load("res://graphics/plants/blumlit/BLUMLIT sadzonka OK.png")
		$textures/smallPlantBAD.texture = load("res://graphics/plants/blumlit/BLUMLIT sadzonka BAD.png")
		$textures/smallPlantDEAD.texture = load("res://graphics/plants/blumlit/BLUMLIT sadzonka DEAD.png")
		$textures/plantOK.texture = load("res://graphics/plants/blumlit/BLUMLIT OK.png")
		$textures/plantBAD.texture = load("res://graphics/plants/blumlit/BLUMLIT BAD.png")
		$textures/plantDEAD.texture = load("res://graphics/plants/blumlit/BLUMLIT DEAD.png")
		$textures/plantREADY.texture = load("res://graphics/plants/blumlit/BLUMLIT OK.png")

func progress_max_value_BLUMLIT(_value):
		if plant_condition == 1:
				plant_condition = plant_condition + 1
		elif plant_level == 0:
				plant_level = 1
		elif plant_level == 1 and added_condition == 0:
				added_condition = 1
		elif plant_level == 1 and added_condition == 1:
				added_condition = 2
		elif plant_level == 1 and added_condition == 2:
				plant_level = 2
		progres_bar.value = 0


func BOOMDI():
	pass
	
	
func progress_max_value_BOOMDI():
		pass

func _on_Timer_to_lose_timeout():
		plant_condition = plant_condition - 1 
		if dead == false:
				check_plant_condition()


func _on_progres_value_changed(value):
		regres_bar.hide()
		if progres_bar.max_value == value:
				if name_plant == "LOBDILLA":
						progress_max_value_LOBDILLA(value)
				elif name_plant == "BLEEDI":
						progress_max_value_BLEEDI(value)
				elif name_plant == "VIOLIK":
						progress_max_value_VIOLIK(value)
				elif name_plant == "BLUMLIT":
						progress_max_value_BLUMLIT(value)
				elif name_plant == "NEEDLI":
						progress_max_value_NEEDLI(value)
				if dead == false:	
						check_plant_condition()


func _on_Tween_tween_completed(_object, _key):
		get_parent().plant_slots[my_column-1] = 0
		queue_free()
