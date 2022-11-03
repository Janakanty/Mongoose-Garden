extends Control

onready var one_hp =   get_node("HBoxContainer/HP1")
onready var two_hp =   get_node("HBoxContainer/HP2")
onready var three_hp = get_node("HBoxContainer/HP3")
onready var four_hp =  get_node("HBoxContainer/HP4")
onready var five_hp =  get_node("HBoxContainer/HP5")
onready var six_hp =   get_node("HBoxContainer/HP6")
onready var seven_hp = get_node("HBoxContainer/HP7")
onready var eight_hp = get_node("HBoxContainer/HP8")
onready var nine_hp =  get_node("HBoxContainer/HP9")

var HP_array = Array()

func init_array():
		HP_array = [one_hp, two_hp, three_hp, four_hp, five_hp, six_hp, seven_hp, eight_hp, nine_hp]


func _ready():
		init_array()
		stat_HP()
		decrease_HP()
		decrease_HP()
		decrease_HP()
		increase_HP()
		increase_HP()
		increase_HP()


func stat_HP():
		if Global.MAX_HP < 10:
				for n in Global.MAX_HP:
						HP_array[n].visible = true


# MAX HP FUNCTIONS

func increase_MAX_HP():
		var pom = 0
		if Global.MAX_HP < 9 : 
				Global.MAX_HP += 1
				Global.HP += 1
				for n in Global.MAX_HP:
						HP_array[n].visible = true
						pom = n
				HP_array[Global.MAX_HP - 1].get_node("HP").visible = true


func decrease_MAX_HP():
		if Global.MAX_HP > 0 : 
				Global.MAX_HP -= 1
				Global.HP -= 1
				HP_array[Global.MAX_HP].visible = false
		if Global.MAX_HP == 0:
				Global.game_over = true


# HP FUNCTIONS


func increase_HP():
		var pom = Global.MAX_HP - Global.HP
		if Global.HP < Global.MAX_HP : 
				Global.HP += 1
				for n  in Global.HP:
					HP_array[Global.MAX_HP - 1 - n].get_node("HP").visible = true


func decrease_HP():
		if Global.HP > 0 : 
				Global.HP -= 1
				for n in (Global.MAX_HP - Global.HP):
						HP_array[n].get_node("HP").visible = false
		if Global.HP == 0:
				Global.game_over = true

