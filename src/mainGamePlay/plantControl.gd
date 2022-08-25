extends Control

var plant

var plant_slots = [0,0,0,0,0,0,0]     # 7 kolumn rozgrywki 
var start = 1                         # zmienna pozwalająca na początku ustalić 
var time_pause = true

var rng                               # zmienne pomocnicze przy losowaniu liczb
var my_random_number


func rand_free_plant_slots() -> int:  # losuje wolny slot tj. bez rośliny
		rng = RandomNumberGenerator.new()
		rng.randomize()
		my_random_number = rng.randi_range(0, 6)
		if plant_slots[my_random_number] == 1:
				print("jeszcze raz")
				rand_free_plant_slots()
		return my_random_number


func rand_next_plant(var i):
		plant = preload("res://src/plants/plant/plant.tscn")
		var next_plant = plant.instance()
		match i:
				1: next_plant.LOBDILLA()
				2: next_plant.BLEEDI()
				3: next_plant.VIOLIK()
				4: next_plant.NEEDLI()
				5: next_plant.BLUMLIT()
				#6:plant = preload("res://src/plants/bleblo/bleblo.tscn")
				


		var rng = rand_free_plant_slots()
		match rng:
			0:
				next_plant.rect_position.x = 211  #Vector2(211,360)
			1:
				next_plant.rect_position.x = 454  #Vector2(454,360)
			2:
				next_plant.rect_position.x = 697  #Vector2(697,360)
			3:
				next_plant.rect_position.x = 940  #Vector2(940,360)
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
		return next_plant


func get_new_plant(var i):             # 
		if plant_slots == [1,1,1,1,1,1,1]:
				print("wszystke pelne") #tu moze być jakaś funkcja odejmująca punkty
		else:
				add_child(rand_next_plant(i))


func _on_gameplayMachineTime_timeout():
		if start == 1:
				get_new_plant(1)
				get_new_plant(2)
				get_new_plant(3)
				get_new_plant(4)
				get_new_plant(5)
				start = 0
		else:
				start = 0
				rng.randomize()
				var my_random_number = rng.randi_range(1, 5)
				get_new_plant(my_random_number)
				time_pause = false
	
