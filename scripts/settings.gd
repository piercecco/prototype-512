extends Control

var SinWave = 0

func _process(delta):
	save.spdrnTimer = global.Options["IsSpeedRunningTimerEnabled"]
	
	$Sprite2D.position.y = 350 + sin(SinWave)*2
	SinWave += 0.05
	
	if global.Options["IsSpeedRunningTimerEnabled"] == true:
		$SpeedRuntext.text = "true"
	else:
		$SpeedRuntext.text = "false"
	if Input.is_action_just_pressed("pause"):
		save.save_game()
		get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_speedrun_check_box_pressed():
	if global.Options["IsSpeedRunningTimerEnabled"] == true:
		global.Options["IsSpeedRunningTimerEnabled"] = false
	else:
		global.Options["IsSpeedRunningTimerEnabled"] = true
