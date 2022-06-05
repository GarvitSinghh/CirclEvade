extends RigidBody2D

var direction = Vector2(rand_range(-250, 250), rand_range(-250, 250)).normalized()

export var max_speed = 500
func _ready():
	pass
	$Light2D.energy = 0.8
	$Light2D.texture_scale = 1.5
	linear_velocity = direction * 500
