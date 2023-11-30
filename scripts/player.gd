extends CharacterBody2D


const SPEED = 200.0
const ACCELLERATION = 50.0
const FRICTION = 25.0
const DASH_STRENGTH = 1000.0

var Scale_0 = 0.5
var Scale_1 = 1.0
var Scale_2 = 1.5
var Scale_3 = 2.0
var CurrentScale = Scale_1

var HasPlayedDeathSound = false

@onready var DimensionTween = get_tree().create_tween()

var CanDash = true
@onready var DashCooldown = $DashCooldown
var DashCooldownAmount = 0.5
var IsCurrentlyDashing = false

@onready var eye = $Eye
var EyeOffsetAmount = 0.9
@onready var Collision = $CollisionShape2D

var ScaleSpeed = {
	0.5: 1.25,
	1.0: 1,
	1: 1,
	1.5: 0.85,
	2.0: 0.7,
	2: 0.7,
}

func _ready():
	global.IsRespawning = false

func _physics_process(delta):
	
	
	global.PlayerPos = position

	$Body.rotation_degrees += 0.5

	# Handles movement on the x axis
	var direction_x = Input.get_axis("walk_left", "walk_right")
	if direction_x and global.PlayerHealth > 0:
		velocity.x = move_toward(velocity.x, direction_x * SPEED * ScaleSpeed[CurrentScale], ACCELLERATION * delta * 60)
		eye.position.x = Collision.position.x + EyeOffsetAmount*direction_x*scale.x
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		eye.position.x = Collision.position.x

	# Handles movement on the y axis
	var direction_y = Input.get_axis("walk_up", "walk_down")
	if direction_y and global.PlayerHealth > 0:
		velocity.y = move_toward(velocity.y, direction_y * SPEED * ScaleSpeed[CurrentScale], ACCELLERATION * delta * 60)
		eye.position.y = Collision.position.y + EyeOffsetAmount*direction_y*scale.y
	else:
		velocity.y = move_toward(velocity.y, 0, FRICTION)
		eye.position.y = Collision.position.y

	

	# Handles dashing
	if Input.is_action_just_pressed("dash") and (direction_x and direction_y) and CanDash == true and global.PlayerHealth > 0:
		$DashSound.play()
		CanDash = false
		IsCurrentlyDashing = true
		DashCooldown.start(DashCooldownAmount)
		velocity = Vector2(move_toward(velocity.x, DASH_STRENGTH*direction_x/1.4, DASH_STRENGTH), \
						   move_toward(velocity.y, DASH_STRENGTH*direction_y/1.4, DASH_STRENGTH))
	elif Input.is_action_just_pressed("dash") and (direction_x or direction_y) and CanDash == true and global.PlayerHealth > 0:
		$DashSound.play()
		CanDash = false
		IsCurrentlyDashing = true
		DashCooldown.start(DashCooldownAmount)
		velocity = Vector2(move_toward(velocity.x, DASH_STRENGTH*direction_x, DASH_STRENGTH), \
						   move_toward(velocity.y, DASH_STRENGTH*direction_y, DASH_STRENGTH))

	global.IsDashing = IsCurrentlyDashing

	if Input.is_action_just_pressed("reset_level"):
		global.PlayerHealth = 0

	DimensionTween = get_tree().create_tween()


	if global.HasEnteredSizeChangingGrid == true:
		DimensionTween.tween_property(self, "scale", Vector2(global.NewSize, global.NewSize), 1)
		$ScaleSound.play()
		CurrentScale = global.NewSize
		global.HasEnteredSizeChangingGrid = false

	# Manages scaling mechanic
	if Input.is_action_just_pressed("change_scale_up") and global.IsRestrictedFromChangingSize == false:
		if CurrentScale == Scale_2:
			$ScaleSound.play()
			CurrentScale = Scale_3
			DimensionTween.tween_property(self, "scale", Vector2(CurrentScale, CurrentScale), 1)
		elif CurrentScale == Scale_1:
			$ScaleSound.play()
			CurrentScale = Scale_2
			DimensionTween.tween_property(self, "scale", Vector2(CurrentScale, CurrentScale), 1)
		elif CurrentScale == Scale_0:
			$ScaleSound.play()
			CurrentScale = Scale_1
			DimensionTween.tween_property(self, "scale", Vector2(CurrentScale, CurrentScale), 1)
	elif Input.is_action_just_pressed("change_scale_down") and global.IsRestrictedFromChangingSize == false:
		if CurrentScale == Scale_3:
			$ScaleSound.play()
			CurrentScale = Scale_2
			DimensionTween.tween_property(self, "scale", Vector2(CurrentScale, CurrentScale), 1)
		elif CurrentScale == Scale_2:
			$ScaleSound.play()
			CurrentScale = Scale_1
			DimensionTween.tween_property(self, "scale", Vector2(CurrentScale, CurrentScale), 1)
		elif CurrentScale == Scale_1:
			$ScaleSound.play()
			CurrentScale = Scale_0
			DimensionTween.tween_property(self, "scale", Vector2(CurrentScale, CurrentScale), 1)
	# Globalizes player scale
	global.CurrentSize = CurrentScale

	if Input.is_action_just_pressed("pause"):
		global.PausePositions["Player"] = position
		if get_parent().get_node("PushableBox"): 
			global.PausePositions["Box1"] = get_parent().get_node("PushableBox").position
		if get_parent().get_node("PushableBox2"): 
			global.PausePositions["Box2"] = get_parent().get_node("PushableBox2").position
		if get_parent().get_node("PushableBox3"): 
			global.PausePositions["Box3"] = get_parent().get_node("PushableBox3").position
		get_tree().change_scene_to_file("res://scenes/pause_menu.tscn")

	if global.ResumedButtonPressed == true:
		position = global.PausePositions["Player"]
		if get_parent().get_node("PushableBox"): 
			get_parent().get_node("PushableBox").position = global.PausePositions["Box1"]
		if get_parent().get_node("PushableBox2"): 
			get_parent().get_node("PushableBox2").position = global.PausePositions["Box2"]
		if get_parent().get_node("PushableBox3"): 
			get_parent().get_node("PushableBox3").position = global.PausePositions["Box3"]
		global.ResumedButtonPressed = false

	# Manages health
	if global.PlayerHealth == 0 and HasPlayedDeathSound == false:
		global.IsChangingLevel = true
		$Body.hide()
		eye.hide()
		$DeathSound.play()
		HasPlayedDeathSound = true
	
	if global.PlayerHealth == -1:
		global.PlayerHealth = 1
		save.total_deaths += 1
		velocity = Vector2(0, 0)
		#position = global.PlayerSpawnPoint
		save.save_game()
		HasPlayedDeathSound = false
		get_tree().change_scene_to_file(global.Levels[global.CurrentLevel])


	move_and_slide()


func _on_dash_cooldown_timeout():
	CanDash = true
	IsCurrentlyDashing = false
