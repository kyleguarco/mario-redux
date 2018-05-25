extends KinematicBody2D

# Devorrin Event Handler

export (int) var Health = 100
export (int) var Speed = 5
export (int) var Delta_Limit = 500
export (bool) var Go = false

onready var _ANIM = get_node("Apperance/Animations")

var count = 0.0
var curr_vector = left()
var collision = false

func _ready():
	set("NAME", "DEVORRIN")
	_ANIM.current_animation = "angry"
	go()

# Controls the ball physics
func push(right):
	if right:
		return Vector2((10 * Speed), 0)
	return Vector2((-10 * Speed), 0)

func right():
	return push(true)

func left():
	return push(false)

func go():
	Go = true

func routine():
	self.queue_free()

func _physics_process(delta):
	if Go:
		if !collision:
			count += 1
			move_and_slide(curr_vector)
			if count > Delta_Limit:
				if count > (Delta_Limit + 0.5):
					curr_vector = left()
				else:
					curr_vector = right()
				count = 0
		else:
			self.queue_free()

# Area Physics
func _on_body_collision(body):
	collision = true
