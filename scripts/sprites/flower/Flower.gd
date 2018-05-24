extends Node2D

onready var _ANIM = get_node("Apperance/Animations")

# Flower collection event handler
var is_collected = false

func _ready():
	_ANIM.current_animation = "sparkle"

func _on_Area_body_entered(body):
	is_collected = true
	self.queue_free()