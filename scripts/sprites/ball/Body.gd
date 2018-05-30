extends KinematicBody2D

export (int) var Speed = 20
export (int) var Delta_Limit = 50

# Used to count delta
var count_phys = false
var last_count = 0

var curr_vector = right()

# Controls the ball physics
func push(right):
	if right:
		return Vector2((10 * Speed), 0)
	return Vector2((-10 * Speed), 0)

func right():
	return push(true)

func left():
	return push(false)

func _physics_process(delta):
	if !count_phys:
		last_count += 1
		if last_count > Delta_Limit:
			count_phys = false
			self.queue_free()
	
	move_and_slide(curr_vector)
