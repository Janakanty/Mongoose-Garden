extends Control

var plant = preload("res://src/plants/lobdilla/lobdilla.tscn")

var plant_slots = [0,0,0,0,0,0,0]
var rng
var my_random_number
var start = 1
var time_pause = true

func _ready():
	pass
#	gameplay_plan_machine()
	

func _process(delta):
	#odlicza czas kiedy daje nową roślinkę
	pass

func rand_number() -> int:
	rng = RandomNumberGenerator.new()
	rng.randomize()
	my_random_number = rng.randi_range(0, 6)
	if plant_slots[my_random_number] == 1:
		rand_number()
	return my_random_number

func get_new_plant(var i):
	if plant_slots == [1,1,1,1,1,1,1]:
		print("wszystke pelne") #tu moze być jakaś funkcja odejmująca punkty
	else:
		
		match i:
			1:plant = preload("res://src/plants/lobdilla/lobdilla.tscn")
			2:plant = preload("res://src/plants/bleedi/bleedi.tscn")
			3:plant = preload("res://src/plants/violik/violik.tscn")
			4:plant = preload("res://src/plants/needli/needli.tscn")
			5:plant = preload("res://src/plants/blumlit/blumlit.tscn")
			6:plant = preload("res://src/plants/bleblo/bleblo.tscn")
		var next_plant = plant.instance()
		var rng = rand_number()
		match rng:
			0:
				next_plant.rect_position.x = 211#Vector2(211,360)
			1:
				next_plant.rect_position.x = 454 #Vector2(454,360)
			2:
				next_plant.rect_position.x = 697 #Vector2(697,360)
			3:
				next_plant.rect_position.x = 940 #Vector2(940,360)
			4:
				next_plant.rect_position.x = 1183 #Vector2(1183,360)
			5:
				next_plant.rect_position.x = 1426 #Vector2(1426,360)
			6:
				next_plant.rect_position.x = 1669 #Vector2(1669,360)
		next_plant.my_column = rng + 1
		plant_slots[rng] = 1
		if start != 0 or i != 6:
			next_plant.get_node("Timer_to_lose").paused = time_pause
		add_child(next_plant)
		
		
func gameplay_plan_machine():
	get_new_plant(1)
	

func _on_gameplayMachineTime_timeout():
	if start == 1:
		get_new_plant(1)
		start = 2
	elif start == 2:
		get_new_plant(2)
		start = 3
	elif start == 3:
		get_new_plant(3)
		start = 0
	else:
		start = 0
		rng.randomize()
		var my_random_number = rng.randi_range(1, 6)
		get_new_plant(my_random_number)
		time_pause = false
	
