extends Node2D
# This is an event handler for Spirit

# Jump handler
export var Can_Jump = true

func block_jump():
	Can_Jump = false

func allow_jump():
	Can_Jump = true

func get_jump():
	return Can_Jump

func _on_ground_collision(body):
	allow_jump()
