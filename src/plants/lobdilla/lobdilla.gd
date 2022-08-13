extends Control


#zmienne rośliny
onready var timer_down = $Timer_to_lose
var my_column = 0
var have_i_grown_up = 0
var plant_level = 0
var plant_condition = 2
var time_down = 5.0
var ready = 0

func _ready():
	timer_down.wait_time = time_down
	
	
func _process(delta):
	pass
	


func grow_way():
	pass

func check_plant_condition():
	#roślina zdycha
	if plant_condition <= 0 and plant_level == 0: #jeśli roślina jest sadzonką i zdecha
		timer_down.stop()
		to_small_plant_DEAD()
	elif plant_condition <= 0 and plant_level == 1:
		timer_down.stop()
		to_plant_DEAD()
	#roślina staje się zdechła
	elif plant_condition == 1 and plant_level == 0:
		to_small_plant_BAD()
	elif plant_condition == 1 and plant_level == 1:
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
	
func to_plant_DEAD():
	$plantBAD.hide()
	$plantDEAD.show()
	
func to_plant_READY():
	$plantOK.hide()
	$plantREADY.show()

func _on_Timer_to_lose_timeout():
	plant_condition = plant_condition - 1 
	check_plant_condition()

		
