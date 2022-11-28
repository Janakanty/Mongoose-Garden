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
var speed_progress = 10
var final_progress_speed


func _ready():
		timer_down.wait_time = time_down
		my_x_position = rect_position.x
		timer_down.start()
		change_mode()	

func _process(delta):
		lose_way()
		grow_way(delta)

func _on_Timer_to_lose_timeout():
		plant_condition = plant_condition - 1 
		if dead == false:
				check_plant_condition()

func _on_Tween_tween_completed(_object, _key):
		get_parent().plant_slots[my_column-1] = 0
		queue_free()

#USUNICIE ROŚLINY Z PLANSZY
func taken_off_the_board():
		if ready == true or dead == true:
				if ready == true:
						get_point()
						effect_plant()
						Global.plant_counter -= 1
						Global.refresh_counter()
						#fajny dźwięk
				if dead == true and name_plant != "BLEBLO":
						lose_one_HP()
				reset_multiplier()
				tween.interpolate_property($".","rect_global_position", null, Vector2(my_x_position,-1000),0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()

func get_point():
		Global.point += point * Global.multiplier
		Global.refresh_point()

func reset_condition():
		timer_down.start()

func effect_plant():
		match name_plant:
				"LOBDILLA":
						pass
				"BLEEDI":
						effect_BLEEDI()
				"VIOLIK":
						effect_VIOLIK()
				"NEEDLI":
						pass
				"BLUMLIT":
						effect_BLIMLIT()
				"BLEBLO":
						effect_BLEBLO()

func grow_way(delta): # mode mówi czy roślina będzie potrzebować pary lub wody.
		final_progress_speed = Global.progress_speed - Global.progress_speed_disadvantage
		if mode == 0: 
				match my_column:
					1:
						if Global.watering_col1 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
					2:
						if Global.watering_col2 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
					3:
						if Global.watering_col3 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
					4:
						if Global.watering_col4 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
					5:
						if Global.watering_col5 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
					6:
						if Global.watering_col6 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
					7:
						if Global.watering_col7 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
		elif mode == 1:	
				match my_column:
					1:
						if Global.evaporating_col1 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
					2:
						if Global.evaporating_col2 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
					3:
						if Global.evaporating_col3 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
					4:
						if Global.evaporating_col4 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
					5:
						if Global.evaporating_col5 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
					6:
						if Global.evaporating_col6 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0
					7:
						if Global.evaporating_col7 == 1:
							progres_bar.value += final_progress_speed * delta
							reset_condition()
						else: $textures/progres.value = 0

func lose_way():
		if dead == false:
				regres_bar.value = timer_down.time_left
				regres_bar.show()

func progres_and_regress_bars_hide():
		progres_bar.hide()
		regres_bar.hide()

func pause_game():
		get_node("Timer_to_lose").paused = true

func loose_game():
		get_node("Timer_to_lose").paused = false

func check_plant_condition():
		match plant_condition:
				0:  #roślina zdycha
					match plant_level:
							0:
								timer_down.stop()
								to_small_plant_DEAD()
							1:
								timer_down.stop()
								to_plant_DEAD()
							2:
								timer_down.stop()
								to_plant_DEAD()
					dead = true
					progres_and_regress_bars_hide()
				1:  #roślina powoli zdycha
					match plant_level:
							0:
								to_small_plant_BAD()
							1:
								to_plant_BAD()
							2:
								to_plant_BAD()
				2:  #roślina staje się OK
					match plant_level:
							0:
								to_small_plant_OK()
							1:
								to_plant_OK()
							2:
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

func to_plant_OK():
		$textures/plantBAD.hide()
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

func to_plant_READY():
		$textures/plantBAD.hide()
		$textures/plantOK.hide()
		$textures/plantREADY.show()
		ready = true

func _on_progres_value_changed(value):
		regres_bar.hide()
		if progres_bar.max_value == value:
				match name_plant:
						"LOBDILLA":
							progress_max_value_LOBDILLA(value)
						"BLEEDI":
							progress_max_value_BLEEDI(value)
						"VIOLIK":
							progress_max_value_VIOLIK(value)
						"BLUMLIT":
							progress_max_value_BLUMLIT(value)
						"NEEDLI":
							progress_max_value_NEEDLI(value)
						"LOBDILLA":
							progress_max_value_LOBDILLA(value)
				if dead == false:	
						check_plant_condition()

# INDIVIDUAL PLANTS 
# 	 Kod rośliny składa się z:
# -  ustawienia początkowych wartości tj. ustawienie tekstur, nazwy, ile punktów da do puli jeśli gracz ją zrealizuje, czas regresu i czas postępu. 
# -  rozwoju rośliny 
# -  właściwości specjalnych

#LOBDILLA
func LOBDILLA(): #dość szybki kwiatek. Mało punktowany ale bardzo szybki do realizacji
		name_plant = "LOBDILLA"
		point = 1
		time_down = Global.value_regress_LOBDILLA
		rect_position.y = rect_position.y - 50
		$textures/progres.max_value = Global.max_progress_LOBDILLA
		$textures/regres.max_value = Global.value_regress_LOBDILLA
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

#BLEEDI
func BLEEDI(): #normalny kwiatek, potencjalnie normalna długoścc podlewania 
		name_plant = "BLEEDI"
		point = 5
		time_down = Global.value_regress_BLEEDI
		rect_position.y = rect_position.y + 9
		$textures/progres.max_value = Global.max_progress_BLEEDI
		$textures/regres.max_value = Global.value_regress_BLEEDI
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

func effect_BLEEDI():
		Global.BLEEDI_column = my_column
		get_parent().BLEEDI_effect()

#VIOLIK
func VIOLIK():  #ten kwiatek co się tylko podlewa parą 
		name_plant = "VIOLIK"
		point = 1
		time_down = Global.value_regress_VIOLIK
		mode = 1
		$textures/progres.max_value = Global.max_progress_VIOLIK
		$textures/regres.max_value = Global.value_regress_VIOLIK
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

func effect_VIOLIK():
		multiplier_next_point() #Efekt rośliny sprawia, że dubluje kolejn punktację rośliny. 

#NEEDLI
func NEEDLI(): 
		name_plant = "NEEDLI"
		point = 9
		time_down = Global.value_regress_NEEDLI
		rect_position.y = rect_position.y - 34
		$textures/progres.max_value = Global.max_progress_NEEDLI
		$textures/regres.max_value = Global.value_regress_NEEDLI
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

func progress_max_value_NEEDLI(_value): #ten kaktus co najdłużej można go zostawić
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

#BLUMLIT
func BLUMLIT(): # ten niebieski co daje życie
		name_plant = "BLUMLIT"
		point = 5
		time_down = Global.value_regress_BLUMLIT
		$textures/progres.max_value = Global.max_progress_BLUMLIT
		$textures/regres.max_value = Global.value_regress_BLUMLIT
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

func effect_BLIMLIT(): # wywouje funkcje increase_HP() ze skryptu HP.gd
		get_one_HP()
		

#BLEBLO
func BLEBLO(): #krzak co utrudnia życie
	name_plant = "BLEBLO"
	point = 5
	ready = true
	dead = true
	Global.progress_speed_disadvantage += 7
	$textures.rect_position.y +=152
	$textures/progres.hide()
	$textures/regres.hide()
	$textures/smallPlantOK.hide()
	$textures/flowerPot.texture = load("res://graphics/plants/bleblo/bleblo.png")

func effect_BLEBLO(): # wywouje funkcje increase_HP() ze skryptu HP.gd
		Global.progress_speed_disadvantage -= 7

#BOOMDI
func BOOMDI():
	pass

func progress_max_value_BOOMDI():
		pass

func get_one_HP():
		get_parent().get_parent().get_node("background/HP_System").increase_HP()
	
func lose_one_HP():
		get_parent().get_parent().get_node("background/HP_System").decrease_HP()

func multiplier_next_point():
		Global.multiplier += 1
		
func reset_multiplier():
		if name_plant != "VIOLIK":
				Global.multiplier = 1

func destroy_plat():
		if my_column == Global.BLEEDI_column-1 or my_column == Global.BLEEDI_column+1:
				tween.interpolate_property($".","rect_global_position", null, Vector2(my_x_position,-1000),0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()
				if name_plant == "BLEBLO":
						effect_BLEBLO()
