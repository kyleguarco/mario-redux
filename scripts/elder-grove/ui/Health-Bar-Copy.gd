extends Control

# Labels
onready var lab_na = $Name
onready var lab_hp = $HP
onready var lab_ep = $EP

# Bars
onready var bar_hp = $Health
onready var bar_ep = $Power

func new_hud():
	return HUD.new(lab_na, lab_hp, lab_ep, bar_hp, bar_ep)

class HUD:
	var lab_na
	var lab_hp
	var lab_ep
	var bar_hp
	var bar_ep
	
	# Declare to re-write this value into the same address
	var calc
	
	var Name = "null"
	
	var Health = 0.0
	const Health_Max = 100.0
	
	var Power = 0.0
	const Power_Max = 100.0
	
	func _init(g, h, j, k, l):
		self.lab_na = g
		self.lab_hp = h
		self.lab_ep = j
		self.bar_hp = k
		self.bar_ep = l
		
	func set_health(h):
		Health = clamp(h, 0, Health_Max)
		
		lab_hp.set_text(str(Health * 1.0) + "%")
		
	func set_power(p):
		Power = clamp(p, 0, Power_Max)
		
		lab_ep.set_text(str(Power * 1.0) + "%")
		
	func set_name(n):
		Name = n
		
		lab_na.text = Name
		
	func update():
		calc = (Health / Health_Max) * 1.0
		lab_hp.set_text(str(calc * 100) + "%")
		bar_hp.set_scale(Vector2(calc, 1))
		
		calc = (Power / Power_Max) * 1.0
		lab_ep.set_text(str(calc * 100) + "%")
		bar_ep.set_scale(Vector2(calc, 1))
		
	func hit(val):
		Health -= (val * 1.0)
		
	func heal(val):
		Health += (val * 1.0)
		
	func powerup(val):
		Power += (val * 1.0)
		
	func powerdown(val):
		Power -= (val * 1.0)
	
