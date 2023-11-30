extends Node2D


func _process(delta):
	if global.PlayerPos.x >= 450 and global.PlayerPos.y >= 550:
		global.CurrentLevel = 10
		get_tree().change_scene_to_file("res://scenes/levels/level_10.tscn")
