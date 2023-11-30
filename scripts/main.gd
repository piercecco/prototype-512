extends Node2D

# Manages the sine wave x value
var SineWaveValue = 0
# Speed at which the sine wave it's travelled
var ShiftAmount = 0.05

@onready var anim = $AnimatedSprite2D

func _ready():
	if global.MenuMusicHasStarted == false:
		global_music.start_menu_music()
		global.MenuMusicHasStarted = true
	save.load_game()

func _process(delta):
	anim.play("default")
	# Manages the movement across the sine wave
	$Title.position = Vector2($Title.position.x, 350 + 2*sin(SineWaveValue))
	$PlayButton.position = Vector2($PlayButton.position.x, 250 + 2*sin(SineWaveValue))
	$OptionsButton.position = Vector2($OptionsButton.position.x, 325 + 2*sin(SineWaveValue))
	$StatsButton.position = Vector2($StatsButton.position.x, 610 + 2*sin(SineWaveValue))
	$QuitButton.position = Vector2($QuitButton.position.x, 400 + 2*sin(SineWaveValue))
	SineWaveValue += ShiftAmount


func _on_play_button_pressed():
	global.CurrentLevel = 1
	global_music.stop_menu_music()
	global_music.start_level_music()
	get_tree().change_scene_to_file(global.Levels[global.CurrentLevel])


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_stats_button_pressed():
	get_tree().change_scene_to_file("res://scenes/stats.tscn")


func _on_quit_button_pressed():
	get_tree().free()


