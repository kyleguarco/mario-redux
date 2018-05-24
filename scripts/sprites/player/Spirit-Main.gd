extends KinematicBody2D

export (int) var Health = 100
export (int) var Speed = 20
export (String) var Name = "Spirit"
export (bool) var Is_Powered = false

onready var regularAni = get_node("Regular/Animations")
onready var regularApp = get_node("Regular")
onready var poweredAni = get_node("Powered/Animations")
onready var poweredApp = get_node("Powered")
onready var ball = preload("res://scenes/sprites/Ball.tscn")

onready var _SPIRIT = get_node("..")
onready var _ANIM = regularAni
onready var _APPE = regularApp
var reset_anim = false

const _gravity = 172
var direction
var velocity = Vector2()
var flip_ball = false

func _ready():
	get_node("Area").connect("area_entered", self, "_on_connect_body")
	

func _process(delta):
	if _SPIRIT.Is_Powered:
		if _APPE == regularApp:
			regularApp.hide()
			poweredApp.show()
			_ANIM.stop(false)
			
			_ANIM = poweredAni
			_APPE = poweredApp
		else:
			regularApp.show()
			poweredApp.hide()
			_ANIM.stop(false)
			
			_ANIM = regularAni
			_APPE = regularApp
		_SPIRIT.powerdown()

func _physics_process(delta):
	direction = Vector2()
	if Input.is_action_pressed("key_w"):
		if _SPIRIT.get_jump():
			move_and_slide(Vector2(0, (-350 * Speed)))
			_SPIRIT.block_jump()
	elif Input.is_action_pressed("key_a"):
		direction.x -= (10 * Speed)
		_APPE.flip_h = true
	elif Input.is_action_pressed("key_d"):
		direction.x += (10 * Speed)
		_APPE.flip_h = false
	elif Input.is_action_pressed("ui_select"):
		self.add_child(ball.instance())
	
	if direction.x == 0:
		_ANIM.current_animation = "idle"
	else:
		_ANIM.current_animation = "walking"
	
	
	velocity.x = direction.x
	velocity.y = (_gravity) + direction.y
	
	move_and_slide(velocity)
	
func _on_connect_body(value):
	var calc = Health - 5
	#hud.hit(5)

func _on_collect_flower(value):
	reset_anim = true
