extends CharacterBody2D

const PushAmount = 25

var CollisionDir = Vector2(0, 0)

func _physics_process(delta):
	if CollisionDir:
		velocity = PushAmount*CollisionDir
	else:
		velocity.x = move_toward(velocity.x, 0, 25)
		velocity.y = move_toward(velocity.y, 0, 25)
	move_and_slide()

func _on_collision_left_body_entered(body):
	if body.name == "Player":
		CollisionDir.x = 1


func _on_collision_right_body_entered(body):
	if body.name == "Player":
		CollisionDir.x = -1


func _on_collision_top_body_entered(body):
	if body.name == "Player":
		CollisionDir.y = 1


func _on_collision_bottom_body_entered(body):
	if body.name == "Player":
		CollisionDir.y = -1


func _on_collision_left_body_exited(body):
	if body.name == "Player":
		CollisionDir.x = 0


func _on_collision_top_body_exited(body):
	if body.name == "Player":
		CollisionDir.y = 0


func _on_collision_bottom_body_exited(body):
	if body.name == "Player":
		CollisionDir.y = 0


func _on_collision_right_body_exited(body):
	if body.name == "Player":
		CollisionDir.x = 0
