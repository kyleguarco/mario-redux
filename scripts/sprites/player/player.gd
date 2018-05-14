extends KinematicBody2D

onready var _NAME = "Spirit"
onready var _HEALTH = 100

const GRAVITY = -9.8

var direction

func _physics_process(delta):
	direction = Vector2()
	if Input.is_action_pressed("key_w"):
		direction.x += 100
	
	move_and_slide(direction)
