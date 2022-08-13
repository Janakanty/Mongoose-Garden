extends Control

var plant = preload("res://src/plants/plant/plant.tscn")

var plant_slots = [0,0,0,0,0,0,0]
var rng
var my_random_number

func _ready():
	get_new_plant()
	get_new_plant()
	get_new_plant()
	get_new_plant()
	get_new_plant()



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
				next_plant.rect_position = Vector2(231,605)
				print("pierwszy slot")
			1:
				next_plant.rect_position = Vector2(474,605)
				print("drugi slot")
			2:
				next_plant.rect_position = Vector2(717,605)
				print("trzeci slot")
			3:
				next_plant.rect_position = Vector2(960,605)
				print("czwarty slot")
			4:
				next_plant.rect_position = Vector2(1203,605)
				print("piaty slot")
			5:
				next_plant.rect_position = Vector2(1446,605)
				print("szosty slot")
			6:
				next_plant.rect_position = Vector2(1689,605)
				print("siodmy slot")
		plant_slots[rng] = 1
		add_child(next_plant)
		
		print(rng , "fef")
		
		
