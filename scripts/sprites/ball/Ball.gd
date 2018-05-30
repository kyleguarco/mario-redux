extends RigidBody2D

export (int) var Speed = 20
export (int) var Damage = 10
export (int) var Delta_Limit = 100

# Used to count delta
var count_phys = false
var last_count = 0
var go = false

var curr_vector = right()

func _ready():
	set_meta("NAME", "BALL")

# Controls the ball physics
func push(right):
	if right:
		return Vector2((10 * Speed), 0)
	return Vector2((-10 * Speed), 0)

func right():
	return push(true)

func left():
	return push(false)

func set_vector(right):
	if right:
		position.x += 20
		curr_vector = right()
	else:
		position.x -= 20
		curr_vector = left()

func go():
	go = true

func _physics_process(delta):
	if !count_phys:
		last_count += 1
		if last_count > Delta_Limit:
			count_phys = false
			self.queue_free()
	
	if go:
		set_linear_velocity(curr_vector)
