extends Control

onready var lab_na = get_node("Name")
onready var lab_hp = get_node("HP")
onready var lab_ep = get_node("EP")
onready var bar_hp = get_node("Health")
onready var bar_ep = get_node("Power")

var calc = 0

var Health = 0.0; var Max_Health = 100.0
var Power = 0.0; var Max_Power = 100.0

func set_name(name):
	lab_na.text = name

func set_health(hp):
	Health = hp

func set_power(po):
	Power = po

func update():
	calc = (Health / Max_Health) * 1.0
	bar_hp.set_scale(Vector2((calc), 1))
	lab_hp.text = (str(calc * 100) + "%")
	
	calc = (Power / Max_Power) * 1.0
	bar_ep.set_scale(Vector2((calc), 1))
	lab_ep.text = (str(calc * 100) + "%")
