extends KinematicBody2D

export var Health = 100
export var Speed = 20
export var Name = "Spirit"

onready var _ANIM = get_node("Apperance/Animations")
onready var _APPER = get_node("Apperance")
onready var _JUMP = get_node("..")

const GRAVITY = 95

var direction
var velocity = Vector2()

func _ready():
	get_node("Area").connect("area_entered", self, "_on_connect_body")
	

func _process(delta):
	pass
	

func _physics_process(delta):
	direction = Vector2()
	if Input.is_action_pressed("key_w"):
		if _JUMP.get_jump():
			move_and_slide(Vector2(0, (-240 * Speed)))
			_JUMP.block_jump()
	elif Input.is_action_pressed("key_a"):
		direction.x -= (10 * Speed)
		_APPER.flip_h = true
	elif Input.is_action_pressed("key_d"):
		direction.x += (10 * Speed)
		_APPER.flip_h = false
	
	if direction.x == 0:
		_ANIM.current_animation = "idle"
	else:
		_ANIM.current_animation = "walking"
	
	
	velocity.x = direction.x
	velocity.y = (GRAVITY) + direction.y
	
	move_and_slide(velocity)
	
func _on_connect_body(value):
	var calc = Health - 5
	#hud.hit(5)
