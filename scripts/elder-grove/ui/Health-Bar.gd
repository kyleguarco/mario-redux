extends Control

onready var bes = 8

func new_hud():
	return HealthBar.new(8)

class HealthBar:
	var lab_na;var lab_hp;var lab_ep;var bar_hp;var bar_ep
	
	func _init(s):
		lab_na = s
		
	func get_s():
		return lab_na
