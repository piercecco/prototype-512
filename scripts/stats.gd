extends Control

@onready var text = $Label

var BestTime = save.best_time
var TotalDeaths = save.total_deaths

var SineWaveValue = 0

@onready var TrophyAnim = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	TrophyAnim.play("default")
	text.text = "Total deaths: " + str(TotalDeaths) + "\nBest time: " + str(BestTime)
	text.position = Vector2(100, 100 + 2*sin(SineWaveValue))
	SineWaveValue += 0.05
	
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
