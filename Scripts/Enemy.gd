#extends KinematicBody2D
extends RigidBody2D

var gravity_vertical = 200.0 * global.gravity
var gravity_horizontal := rand_range(-80.0, 10.0)
export var rotation_speed := 100.0

const UP := Vector2.UP
var velocity := Vector2.ZERO
var initial_pos := Vector2.ZERO

var rng := RandomNumberGenerator.new()

func _ready() -> void:
#	rng.randomize()
#	position.x = rng.randf_range(130.0, 730.0)
#	position.y = rng.randf_range(1080.0, 1250.0)
#	initial_pos = Vector2(position.x, position.y)
	pass

func _process(delta: float) -> void:
	rng.randomize()
	if global.difficulty < 4 or global.previous_velocity == 0:
		velocity.y = rng.randf_range(gravity_vertical, gravity_vertical+(50*global.gravity)) * delta * global.difficulty
		if global.difficulty == 4:
			velocity.y = gravity_vertical * delta
	else:
		velocity.y = global.previous_velocity + (0.05 * global.gravity)

	velocity.x = gravity_horizontal * delta
	
	
	position += Vector2(velocity.x, velocity.y)


func _on_VisibilityNotifier2D_screen_exited():
	global.previous_velocity = velocity.y
	$"../Timers"._update_timers()
	queue_free()
