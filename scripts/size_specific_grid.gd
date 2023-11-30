extends Area2D

@export var size_type = 1.0


func _on_body_entered(body):
	if body.name == "Player":
		global.IsRestrictedFromChangingSize = true
		if global.CurrentSize != size_type:
			global.PlayerHealth = 0


func _on_body_exited(body):
	if body.name == "Player":
		global.IsRestrictedFromChangingSize = false
