extends Area2D

var isEnabled = false

@export var color = "color"
@export var id = 0

@onready var animation = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isEnabled == true:
		global.EnabledButtons[id] = true
		if color == "red":
			animation.play("on_red")
		elif color == "green":
			animation.play("on_green")
		elif color == "blue":
			animation.play("on_blue")
		elif color == "pink":
			animation.play("on_pink")
	else:
		global.EnabledButtons[id] = false
		if color == "red":
			animation.play("off_red")
		elif color == "green":
			animation.play("off_green")
		elif color == "blue":
			animation.play("off_blue")
		elif color == "pink":
			animation.play("off_pink")


func _on_body_entered(body):
	if body.name == "PushableBox" or body.name == "PushableBox2" or body.name == "PushableBox3":
		isEnabled = true


func _on_body_exited(body):
	if body.name == "PushableBox" or body.name == "PushableBox2" or body.name == "PushableBox3":
		isEnabled = false
