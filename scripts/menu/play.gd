extends Button

const PLAY_SCENE_PATH = "res://scenes/elder-grove/Elder-Grove.tscn"

func _pressed():
	get_tree().change_scene(PLAY_SCENE_PATH)
	
