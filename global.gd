extends Node

var mongoose_active : bool = false
var start_gameplay : bool = false
var notes_showed : bool = false
var pause : bool = false
var pause_by_p : bool = false

var point = 0
var MAX_HP = 3
var HP = 3
var game_over = false

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


func refresh_point():
	print(point)
	get_parent().get_node("/root/main/background/point").text = str(point)
