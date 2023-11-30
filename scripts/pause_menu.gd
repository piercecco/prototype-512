extends Control

var SineWaveValue = 0
var ShiftAmount = 0.05

@onready var anim = $AnimatedSprite2D

@onready var OverlayAnimation = $Overlay
var OverlayAnimationState = "expanding"

func _ready():
	OverlayAnimation.scale = Vector2(1.5, 1.5)

func _process(delta):
	
	print(OverlayAnimation.scale)
	
	if OverlayAnimation.scale <= Vector2(1.15, 1.15):
		OverlayAnimationState = "expanding"
	elif OverlayAnimation.scale >= Vector2(1.6, 1.6):
		OverlayAnimationState = "contracting"
	
	if OverlayAnimationState == "expanding":
		OverlayAnimation.scale += Vector2(0.0025, 0.0025)
	elif OverlayAnimationState == "contracting":
		OverlayAnimation.scale -= Vector2(0.0025, 0.0025)
	
	# Manages the movement across the sine wave
	$Resume.position = Vector2($Resume.position.x, 250 + 2*sin(SineWaveValue))
	$Quit.position = Vector2($Quit.position.x, 325 + 2*sin(SineWaveValue))
	SineWaveValue += ShiftAmount


func _on_resume_pressed():
	global.ResumedButtonPressed = true
	get_tree().change_scene_to_file(global.Levels[global.CurrentLevel])


func _on_quit_pressed():
	get_tree().free()
