extends Node

var timer = Timer.new()  
var StartedGame = false

var Options = {
	"IsSpeedRunningTimerEnabled": false,
	"IsFalse": true,
}

var PlayerHealth = 5
var IsRespawning = false
var PlayerPos = Vector2(0, 0)
var PlayerSpawnPoint = Vector2(0, 0)
var IsDashing
var CurrentSize
var HasEnteredSizeChangingGrid = false
var NewSize = 1
var IsRestrictedFromChangingSize = false

var ResumedButtonPressed = false
var PausePositions = {
	"Player": Vector2(0, 0),
	"Box1": Vector2(0, 0),
	"Box2": Vector2(0, 0),
	"Box3": Vector2(0, 0),
}

var IsChangingLevel = false

var EnabledButtons = {
	0: "ALWAYS FALSE",
	1: false,
	2: false,
	3: false,
	4: false,
	5: false,
	6: false,
	7: false,
	8: false,
	9: false,
	10: false,
	# ... and so on
}

var MenuMusicHasStarted = false

var CurrentLevel = 1
var Levels = {
	1: "res://scenes/levels/level_1.tscn",
	2: "res://scenes/levels/level_2.tscn",
	3: "res://scenes/levels/level_3.tscn",
	4: "res://scenes/levels/level_4.tscn",
	5: "res://scenes/levels/level_5.tscn",
	6: "res://scenes/levels/level_6.tscn",
	7: "res://scenes/levels/level_7.tscn",
	8: "res://scenes/levels/level_8.tscn",
	#9: "res://scenes/levels/level_9.tscn",
	9: "res://scenes/levels/level_10.tscn",
	10: "res://scenes/levels/level_11.tscn",
	11: "res://scenes/levels/level_12.tscn",
	"test": "res://scenes/levels/test_map.tscn",
}

func _process(delta):
	if StartedGame == true:
		add_child(timer)  
		timer.start(9999999)
		StartedGame = false
