extends Node


var d := 0.0
export var radius = 200.0
export var speed = 2
var s = 1

func _ready():
	global.started = false


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		s *= -1

func _process(delta: float) -> void:
	d += s * delta
	
	#if Input.is_action_just_pressed("switch"):
	#	s *= -1
	if global.difficulty <= 3:
		$Player.position = Vector2(
			sin(d * speed * (0.75 + 0.25*(global.difficulty-1)*(global.difficulty-1))) * radius,
			cos(d * speed * (0.75 + 0.25*(global.difficulty-1)*(global.difficulty-1))) * radius
		) + Vector2(288, 512)
		
	else:
		if global.started:
			speed += 0.000025
		$Player.position = Vector2(
			sin(d * speed) * radius,
			cos(d * speed) * radius
		) + Vector2(288, 512)

func _reset_speed():
	speed = 2

