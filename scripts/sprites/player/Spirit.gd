extends Node2D
# This is an event handler for Spirit

# Jump handler
export (bool) var Can_Jump = true

# Flower handler
export (bool) var Is_Powered = false

# Jump Bodies
func block_jump():
	Can_Jump = false

func allow_jump():
	Can_Jump = true

func get_jump():
	return Can_Jump

func _on_ground_collision(body):
	allow_jump()

func powerup():
	Is_Powered = true

func powerdown():
	Is_Powered = false

func _on_flower_collect(body):
	powerup()
