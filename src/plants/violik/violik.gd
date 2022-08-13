extends Control


#zmienne rośliny
onready var timer_down = $Timer_to_lose
var my_column = 0 #kolumna w którejjest rośłina
var have_i_grown_up = 0 
var plant_level = 0 #poziom rośliny 0,1,2
var plant_condition = 2 #stan rośliny
var time_down = 5.0 # czas w którym roślina zdycha
var ready = 0 #czy jest gotowa do wzicia 0 - nie, 1 - tak

func _ready():
	timer_down.wait_time = time_down
	
	
func _process(delta):
	pass
	

func grow_way():
	#każda roślina ma swój specjalny grow way
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
	queue_free()

func _on_Timer_to_lose_timeout():
	plant_condition = plant_condition - 1 
	check_plant_condition()


