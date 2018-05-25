extends KinematicBody2D

# Devorrin Event Handler

export (int) var Health = 100
export (int) var Speed = 5
export (int) var Delta_Limit = 500
export (bool) var Go = false

onready var _APPE = get_node("Apperance")

onready var ball = preload("res://scenes/sprites/Death.tscn")

var count = 0.0
var curr_vector = left()
var collision = false

func _ready():
	set("NAME", "FLY")
	_APPE.animation = "flying"
	go()

# Controls physics
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

func _physics_process(delta):
	if Go:
		if !collision:
			count += 1
			move_and_slide(curr_vector)
			if count > Delta_Limit:
				if curr_vector == right():
					_APPE.flip_h = false
					curr_vector = left()
				else:
					_APPE.flip_h = true
					curr_vector = right()
				count = 0
				
				var flip = true
				if _APPE.flip_h == true:
					flip = false
				
				var b = ball.instance()
				get_parent().add_child(b)
				b.position.x = self.position.x
				b.position.y = self.position.y
				b.set_vector(flip)
				b.go()
		else:
			self.queue_free()

func _on_body_collide(body):
	if body.get_name() == "Ball":
		collision = true
