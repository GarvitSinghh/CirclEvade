extends Area2D


export var gravity_vertical := -100.0
export var gravity_horizontal := 0

const UP := Vector2.UP
var velocity := Vector2.ZERO
var initial_pos := Vector2.ZERO

var rng := RandomNumberGenerator.new()

onready var animation_player := $AnimationPlayer

func _ready() -> void:
	rng.randomize()
	position.x = rng.randf_range(100.0, 500.0)
	position.y = rng.randf_range(1040.0, 1150.0)
	initial_pos = Vector2(position.x, position.y)
	
	gravity_horizontal = -10
	
	animation_player.play("Spin")
	

func _process(delta: float) -> void:
	
	velocity.y += gravity_vertical * delta
	velocity.x += gravity_horizontal * delta
	
	
	position = Vector2(velocity.x, velocity.y) + initial_pos


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_Bonus_area_entered(area):

	queue_free()
