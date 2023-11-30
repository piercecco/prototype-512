extends Area2D

# 0 = static, 1 = rotating
@export var type = 0
@export var rotation_speed = 1
@export var rotation_direction = 1

@onready var animation = $AnimatedSprite2D

func _on_body_entered(body):
	if body.name == "Player" and global.IsDashing == false and global.IsRespawning == false:
		global.PlayerHealth = 0
	elif body.name == "Player" and global.IsDashing == true:
		$DodgeSound.play()


func _on_body_exited(body):
	if body.name == "Player" and global.IsDashing == false and global.IsRespawning == false:
		global.PlayerHealth = 0
