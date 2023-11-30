extends Area2D

var best_time

func _on_body_entered(body):
	if body.name == "Player":
		best_time = snapped(9999999 - global.timer.time_left, 0.001)
		if best_time > save.best_time:
			save.best_time = best_time
		save.save_game()
		get_tree().change_scene_to_file("res://scenes/stats.tscn")
