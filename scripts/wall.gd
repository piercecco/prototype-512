extends CharacterBody2D


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		global.PlayerHealth = 0
