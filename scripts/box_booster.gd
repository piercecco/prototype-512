extends Area2D

@export var Direction = Vector2(1, 0)

const SPEED_MULT = 2

@onready var animation = $AnimatedSprite2D

var BoxHasToMove = false
var BoxBody

func _process(delta):
	animation.play("default")


	if Direction == Vector2(1, 0):
		rotation = 0
	elif Direction == Vector2(-1, 0):
		rotation = 3.14
	elif Direction == Vector2(0, 1):
		rotation = 3.14/2
	elif Direction == Vector2(0, -1):
		rotation = (3*3.14)/2
	else:
		rotation += 1

	if BoxHasToMove == true:
		BoxBody.position.x += Direction[0]*SPEED_MULT
		BoxBody.position.y += Direction[1]*SPEED_MULT


func _on_body_entered(body):
	if body.name == "PushableBox" or body.name == "PushableBox2" or body.name == "PushableBox3":
		BoxHasToMove = true
		BoxBody = body


func _on_body_exited(body):
	if body.name == "PushableBox" or body.name == "PushableBox2" or body.name == "PushableBox3":
		BoxHasToMove = false
