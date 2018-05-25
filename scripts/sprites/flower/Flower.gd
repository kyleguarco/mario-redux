extends Node2D

onready var _AREA = get_parent().get_node(".")
onready var _ANIM = get_node("Apperance/Animations")

func _ready():
	set("NAME", "FLOWER")
	_ANIM.current_animation = "sparkle"
	

func _on_flower_collect(body):
	if body.get_name() == "Spirit":
		_ANIM.stop(false)
		_AREA.queue_free()
