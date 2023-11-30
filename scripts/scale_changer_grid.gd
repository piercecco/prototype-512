extends Area2D

@export var dimension = 1.0

@export var id = 0

@onready var animation = $AnimatedSprite2D

func _process(delta):
	if animation and global.EnabledButtons[id] == false:
		animation.play("on")
	elif animation and global.EnabledButtons[id] == true:
		animation.play("off")

func _on_body_entered(body):
	if body.name == "Player" and global.EnabledButtons[id] == false:
		global.IsRestrictedFromChangingSize = true
		global.HasEnteredSizeChangingGrid = true
		global.NewSize = dimension


func _on_body_exited(body):
	if body.name == "Player":
		global.IsRestrictedFromChangingSize = false
