extends KinematicBody2D

onready var _NAME = "Spirit"
onready var _HEALTH = 100
onready var _SPEED = 15
onready var _ANIM = get_node("Animations")

const GRAVITY = -9.8

var direction

func _physics_process(delta):
	_ANIM.set_animation("idle_shield")
	print(_ANIM.animation)
	direction = Vector2()
	if Input.is_action_pressed("key_w"):
		direction.y += (10 * _SPEED)
	elif Input.is_action_pressed("key_s"):
		direction.y += (-10 * _SPEED)
	elif Input.is_action_pressed("key_a"):
		direction.x += (-10 * _SPEED)
	elif Input.is_action_pressed("key_d"):
		direction.x += (10 * _SPEED)
	
	move_and_slide(direction)
