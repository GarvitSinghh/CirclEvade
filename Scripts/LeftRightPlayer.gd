extends Node

export var speed = 5
export var direction = 1

export var limits = 200

func _ready():
	$Player.position = Vector2(288, 512)


func _physics_process(delta):
	$Player.position = Vector2($Player.position.x + (speed*(0.25+global.difficulty) * direction), $Player.position.y)
	if  $Player.position.x > 288+limits or $Player.position.x < 288-limits:
		change_direction()
		if $Player.position.x > 288+limits:
			$Player.position.x = 286+limits
		if $Player.position.x < 288-limits:
			$Player.position.x = 290-limits
			
#	if Input.is_action_pressed("switch"):
#		print(get_viewport().get_mouse_position())
func _unhandled_input(event):
	if event is InputEventScreenTouch && event.is_pressed():
		change_direction()
	
func change_direction():
	direction *= -1
