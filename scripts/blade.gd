extends Area2D

@export var dir = 1
@export var size = 2

var SineWavePos = 0

func _process(delta):
	if dir == -1:
		scale = Vector2(-size, size)
	else:
		scale = Vector2(size, size)

	position += Vector2(10*sin(SineWavePos), 0)
	SineWavePos += 0.1*dir


func _on_body_entered(body):
	if body.name == "Player":
		global.PlayerHealth = 0
