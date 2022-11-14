extends Node

var mongoose_active : bool = false
var start_gameplay : bool = false
var notes_showed : bool = false
var pause : bool = false
var pause_by_p : bool = false

var plant_counter = 20
var point = 0
var expected_point_to_win = 500
var MAX_HP = 3
var HP = 3
var game_over = false

# WARTOŚCI ROŚLIN
var progress_speed = 10
var progress_speed_disadvantage = 0

#LOBDILLA
var max_progress_LOBDILLA = 10
var value_regress_LOBDILLA = 20

#BLEEDI
var max_progress_BLEEDI = 20
var value_regress_BLEEDI = 20

#VIOLIK
var max_progress_VIOLIK = 40
var value_regress_VIOLIK = 20

#NEEDLI
var max_progress_NEEDLI = 30
var value_regress_NEEDLI = 20

#BLUMLIT
var max_progress_BLUMLIT = 30
var value_regress_BLUMLIT = 20

# FUNKCJE 
func refresh_point():
	get_parent().get_node("/root/main/background/point").text = str(point)
	
func refresh_counter():
	get_parent().get_node("/root/main/background/counter").text = str(plant_counter)

# ZMIENNE ZPRAWDZAJĄ CZY KTOŚ JE AKTUALNIE PODLEWA LUB NAWILŻA
# kolumna 1
var watering_col1 = 0
var evaporating_col1 = 0
# kolumna 2
var watering_col2 = 0
var evaporating_col2 = 0
# kolumna 3
var watering_col3 = 0
var evaporating_col3 = 0
# kolumna 4
var watering_col4 = 0
var evaporating_col4 = 0
# kolumna 5
var watering_col5 = 0
var evaporating_col5 = 0
# kolumna 6
var watering_col6 = 0
var evaporating_col6 = 0
# kolumna 7
var watering_col7 = 0
var evaporating_col7 = 0
