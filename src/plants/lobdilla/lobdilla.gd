extends Control

#specyfika każdy kwiatek ma swoje warunki. Ma czas na sobie. 
onready var timer_down = $Timer_to_lose
var my_column = 0
var have_i_grown_up = 0
var plant_level = 0
var plant_condition = 2
var time_down = 5.0

func _ready():
	timer_down.wait_time = time_down
	
	
func _process(delta):
	pass
	
func way_to_grow_or_lose():
	pass

func grow_way():
	pass

func check_plant_condition():
	pass

func _on_Timer_to_lose_timeout():
	plant_condition = plant_condition - 1 
	if plant_condition <= 0:
		timer_down.stop()
		
