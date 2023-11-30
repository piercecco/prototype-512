extends Control

@onready var animation = $SizeBar
@onready var death = $DeathAnim
@onready var spdrTimer = $SpeedRunTimer
@onready var console = $Console

@onready var PlayerLight = $PlayerLight

var LevelTexts = {
	1: "Running Simulation-Alpha",
	2: "Instructing S.C.A.L.E. functionality",
	3: "Enabling S.A. Hazard Protocol",
	4: "Instructing the machine of differences",
	5: "Reinforcing S.C.A.L.E. knowledge",
	6: "Loading interactables.sh",
	7: "Testing machine adaptability",
	8: "Putting the machine on a claustrophobic environment",
	9: "Enabling S.A. Enhanced Hazard Protocol",
	10: "Adding interactables",
	11: "Reinforcing interactables knowledge",
}

var TextEnder = "..."

@onready var LevelTransition = $LevelTransition

func _ready():
	$ChangeTextTimer.start(1)
	animation.position = Vector2(450, 450)
	LevelTransition.position = Vector2(0, 0)

func _process(delta):
	if global.IsChangingLevel == false:
		if LevelTransition.position.x >= -699:
			LevelTransition.position.x -= 23
		else:
			LevelTransition.position.x = -699
	else:
		if LevelTransition.position.x < 0:
			LevelTransition.position.x += 23
		else:
			LevelTransition.position.x = 0
			global.IsChangingLevel = false


	console.text = LevelTexts[global.CurrentLevel] + TextEnder
	
	PlayerLight.position = global.PlayerPos
	
	if global.Options["IsSpeedRunningTimerEnabled"] == true:
		spdrTimer.show()
	else:
		spdrTimer.hide()
	
	spdrTimer.text = "Current Time:  " + str(snapped(9999999 - global.timer.time_left, 0.01))
	
	if global.CurrentLevel == 5 and $Level5CustomMarker:
		$Level5CustomMarker.rotation_degrees += 10
		if animation.position.x <= 15:
			animation.position = Vector2(15, 35)
			$Level5CustomMarker/Level5CustomMarker.emitting = false
			$Level5CustomMarker/Level5CustomMarker2.emitting = false
		else:
			$Level5CustomMarker.position = animation.position
			animation.position.x = move_toward(animation.position.x, 15, 3)
			animation.position.y = move_toward(animation.position.y, 35, 2.9)
	else:
		animation.position = Vector2(15, 35)


	if global.CurrentSize == 0.5:
		animation.play("size_05")
	elif global.CurrentSize == 1:
		animation.play("size_1")
	elif global.CurrentSize == 1.5:
		animation.play("size_15")
	elif global.CurrentSize == 2:
		animation.play("size_2")

	if global.PlayerHealth <= 0:
		global.IsRespawning = true
		death.play("death")
	else:
		death.play("none")

	if death.animation == "death" and death.frame == 19:
		global.PlayerHealth = -1
		death.play("none")



func _on_change_text_timer_timeout():

	if TextEnder == "...":
		TextEnder = ""
	elif TextEnder == "":
		TextEnder = "."
	elif TextEnder == ".":
		TextEnder = ".."
	elif TextEnder == "..":
		TextEnder = "..."
	
	$ChangeTextTimer.start(0.5)
