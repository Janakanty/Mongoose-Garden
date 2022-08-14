extends Control

var plant = preload("res://src/plants/lobdilla/lobdilla.tscn")

var plant_slots = [0,0,0,0,0,0,0]
var rng
var my_random_number


func _ready():
	gameplay_plan_machine()


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

func get_new_plant():
	if plant_slots == [1,1,1,1,1,1,1]:
		print("wszystke pelne") #tu moze być jakaś funkcja odejmująca punkty
	else:
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
		add_child(next_plant)
		
func gameplay_plan_machine():
	get_new_plant()
	set_plant()
	get_new_plant()
	plant = preload("res://src/plants/violik/violik.tscn")
	get_new_plant()
	
func set_plant():
	plant = preload("res://src/plants/lobdilla/lobdilla.tscn")
	plant = preload("res://src/plants/bleedi/bleedi.tscn")
		
