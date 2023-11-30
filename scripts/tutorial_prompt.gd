extends AnimatedSprite2D

@export var num = 1

# Manages the sine wave x value
var SineWaveValue = 0
# Speed at which the sine wave it's travelled
var ShiftAmount = 0.05

func _process(delta):
	if num == 1:
		play("level_1")
	elif num == 2:
		play("level_2")
	elif num == 3:
		play("level_3")
	elif num == 4:
		play("level_4")
	elif num == 5:
		play("size_05")
	elif num == 6:
		play("size_1")
	elif num == 7:
		play("size_15")
	elif num == 8:
		play("size_2")

	# Manages the movement across the sine wave
	position = Vector2(position.x, position.y + sin(SineWaveValue)/5)
	SineWaveValue += ShiftAmount
