extends KinematicBody2D

onready var regularAni = get_node("Regular/Animations")
onready var regularApp = get_node("Regular")
onready var poweredAni = get_node("Powered/Animations")
onready var poweredApp = get_node("Powered")
onready var shieldApp = get_node("Shield")
onready var shieldAni = get_node("Shield/Animations")
onready var ball = preload("res://scenes/sprites/Ball.tscn")

onready var _SPIRIT = get_node("..")
onready var _ANIM = regularAni
onready var _APPE = regularApp
onready var _SPEED = _SPIRIT.Speed

var reset_anim = false

const _gravity = 60
var direction
var velocity = Vector2()
var flip_ball = false

# Jump control; y should be set once
var jH = 650
var seconds = 9
var curr_sec = 0
var y
var count = false
# Set once, then reset
var set_loc = true

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
	if reset_anim:
		if _SPIRIT.Is_Shielding:
			# bUGG - Shield doesn't show
			shieldApp.show()
			shieldApp.show_on_top = true
			shieldAni.current_animation = "idle"
		else:
			shieldAni.current_animation = "breaking"
			shieldAni.stop(false)
			shieldApp.hide()
			
			regularApp.show()
			poweredApp.hide()
			_ANIM.stop(false)
			
			_ANIM = regularAni
			_APPE = regularApp
			reset_anim = false

func _physics_process(delta):
	direction = Vector2()
	if Input.is_action_pressed("key_w"):
		if _SPIRIT.get_jump():
			direction.y = 0
			_SPIRIT.block_jump()
			
	elif Input.is_action_pressed("key_a"):
		direction.x -= (10 * _SPEED)
		_APPE.flip_h = true
		shieldApp.position.x = self.position.x - 20
		shieldApp.flip_h = true
		
	elif Input.is_action_pressed("key_d"):
		direction.x += (10 * _SPEED)
		_APPE.flip_h = false
		shieldApp.position.x = self.position.x + 20
		shieldApp.flip_h = false
		
	elif Input.is_action_pressed("ui_select"):
		var flip = true
		if _APPE.flip_h == true:
			flip = false
		
		var b = ball.instance()
		get_parent().add_child(b)
		b.position.x = self.position.x
		b.position.y = self.position.y
		b.set_vector(flip)
		b.go()
	
	if direction.x == 0:
		_ANIM.current_animation = "idle"
	else:
		_ANIM.current_animation = "walking"
	
	velocity.x = direction.x
	velocity.y = (_gravity)
	
	if !_SPIRIT.get_jump():
		var mov = 0.0
		if set_loc:
			y = self.position.y
			set_loc = false
		
		if !count:
			#mov = Vector2((curr_sec * delta), (((-9.6*curr_sec) + y) / jH) * 2)
			if curr_sec < seconds:
				velocity.y += (-(curr_sec * 2.6) + jH)
				curr_sec += 1.0
				if curr_sec == seconds:
					count = true
		else:
			if curr_sec > -1.0:
				velocity.y += ((curr_sec * 2.6) - jH)
				curr_sec -= 1.0
				if curr_sec == -1:
					count = false
					#_SPIRIT.allow_jump()
	print(str(velocity))
	move_and_slide(velocity)

func _on_connect_body(value):
	pass

func _on_collect_flower(value):
	reset_anim = true
