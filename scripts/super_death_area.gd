extends Area2D

@export var type = 0 # Can be either 0 or 1, 0 = static, 1 = rotating
@export var rotation_speed = 1
@export var rotation_direction = 1

func _process(delta):
	if self.type == 1:
		rotation_degrees += rotation_speed * rotation_direction * delta * 60


func _on_body_entered(body):
	if body.name == "Player":
		global.PlayerHealth = 0
