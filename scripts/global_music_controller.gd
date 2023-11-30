extends Node


func start_menu_music():
	$MenuMusic.play()

func stop_menu_music():
	$MenuMusic.stop()

func start_level_music():
	$LevelMusic.play()

func stop_level_music():
	$LevelMusic.stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
