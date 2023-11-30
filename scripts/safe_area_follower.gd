extends Area2D

var IsFollowing = false

func _process(delta):
	if Input.is_action_just_pressed("connect_to_safeArea"):
		if IsFollowing == true:
			IsFollowing = false
		else:
			IsFollowing = true

	if IsFollowing == true:
		position.x = lerp(position.x, global.PlayerPos.x, 0.05)
		position.y = lerp(position.y, global.PlayerPos.y, 0.05)
