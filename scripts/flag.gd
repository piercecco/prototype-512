extends Area2D


func _on_body_entered(body):
	if body.name == "Player" or position.distance_to(global.PlayerPos) <= 250:
		$Exit.play()
		global.IsChangingLevel = true
		$Timer.start(0.5)


func _on_timer_timeout():
	global.CurrentLevel += 1
	get_tree().change_scene_to_file(global.Levels[global.CurrentLevel])
