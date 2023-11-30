extends StaticBody2D

@export var type = "medium/large"
@export var color = "color"
@export var id = 0
@export var opening_speed = 1
@export var opening_dir = 1

@onready var animation = $AnimatedSprite2D

var StartLocation

@onready var MediumDoor = $MediumDoorCollision
@onready var LargeDoor = $LargeDoorCollision

@onready var MediumDoorShadow = $MediumDoorShadow
@onready var LargeDoorShadow = $LargeDoorShadow

func _ready():
	StartLocation = position.x

func _process(delta):
	if global.EnabledButtons[id] == true:
		MediumDoor.scale = Vector2(0, 0)
		LargeDoor.scale = Vector2(0, 0)
		if opening_dir == 1:
			if position.x != StartLocation+250:
				position.x += opening_speed
		else:
			if position.x != StartLocation-250:
				position.x -= opening_speed
	else:
		MediumDoor.scale = Vector2(1, 1)
		LargeDoor.scale = Vector2(1, 1)
		if position.x <= StartLocation:
			position.x += 1
		else:
			position.x -= 1

	if type == "large":
		MediumDoor.scale = Vector2(0, 0)
		MediumDoorShadow.hide()
		if global.EnabledButtons[id] == false:
			LargeDoorShadow.show()
		else:
			LargeDoorShadow.hide()
		if color == "red":
			animation.play("large_red")
		elif color == "green":
			animation.play("large_green")
		elif color == "blue":
			animation.play("large_blue")
		elif color == "pink":
			animation.play("large_pink")
	else:
		LargeDoor.scale = Vector2(0, 0)
		LargeDoorShadow.hide()
		if global.EnabledButtons[id] == false:
			MediumDoorShadow.show()
		else:
			MediumDoorShadow.hide()
		if color == "red":
			animation.play("medium_red")
		elif color == "green":
			animation.play("medium_green")
		elif color == "blue":
			animation.play("medium_blue")
		elif color == "pink":
			animation.play("medium_pink")
