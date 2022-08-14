extends Control

onready var tween = get_node("Tween")

#zmienne rośliny
var my_column = 0 #kolumna w którejjest roślina
var have_i_grown_up = 0 
var plant_level = 0 #poziom rośliny 0,1,2
var plant_condition = 2 #stan rośliny
var time_down = 5.0 # czas w którym roślina zdycha
var ready = 0 #czy jest gotowa do wzicia 0 - nie, 1 - tak
var my_x_position 


func _ready():
	my_x_position = rect_position.x


func taken_off_the_board():
	Global.point += 1
	#fajny dźwięk
	tween.interpolate_property($".","rect_global_position", null, Vector2(my_x_position,-1000),0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	#tutaj zrobić aktualne punkty


func _on_Tween_tween_completed(object, key):
	queue_free()
