extends Button

onready var Commerical = get_parent().get_node("Commerical")

func _pressed():
	Commerical.playing = true
	Commerical.play(0.0)
