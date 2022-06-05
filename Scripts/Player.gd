extends Area2D

signal hit
signal point
signal win


export var explosion_effect : PackedScene =  load("res://Scenes/Effects/DeathExplosion.tscn")
export var bonus_effect : PackedScene = load("res://Scenes/Effects/BonusEffect.tscn")

onready var light2d = $Light2D
export var points = 0

export var winning_energy = 1.4
var current_energy : float
var current_texture_scale : float

var updated_energy: float
var updated_texture_scale: float


func _unhandled_input(event):
	if event is InputEventScreenTouch and !$TurnSound.playing:
		$TurnSound.play()


func _ready() -> void:
	$PointSound.pitch_scale = 1
	connect("hit", get_parent().get_parent(), "_on_Player_hit")
	connect("point", get_parent().get_parent(), "_on_Player_point")
	connect("win", get_parent().get_parent(), "_on_Player_win")
	connect("point", get_parent(), "_on_player_point")
	
	light2d.energy = 0.8
	light2d.texture_scale = 0.8
	
	current_energy = light2d.energy
	current_texture_scale = light2d.texture_scale
	
	updated_energy = current_energy
	updated_texture_scale = current_texture_scale

	
func start():
	points = 0
	$PointSound.pitch_scale = 1
	light2d.energy = 0.8
	light2d.texture_scale = 0.8
	
	current_energy = light2d.energy
	current_texture_scale = light2d.texture_scale
	
	updated_energy = current_energy
	updated_texture_scale = current_texture_scale
	
	show()
	$CollisionShape2D.disabled = false
	
	for i in get_parent().get_parent().get_children():
		if "Enemy" in i.name or "Bonus" in i.name:
			i.queue_free()
			

func _physics_process(delta):
	current_energy = light2d.energy
	current_texture_scale = light2d.texture_scale
	
	
	if current_energy < updated_energy:

		light2d.energy += 3 * delta
	
	if current_texture_scale < updated_texture_scale:
		light2d.texture_scale += 3 * delta
	

func _on_Player_body_entered(body):
	
	var effect = explosion_effect.instance()
	
	get_tree().get_root().add_child(effect)
	effect.position = position
	
	# Hacks
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	
	if !$DeathSound.playing:
		$DeathSound.play()
		
	emit_signal("hit")


func _on_Player_area_entered(area):
	
	var effect = bonus_effect.instance()
	
	get_tree().get_root().add_child(effect)
	effect.position = position
	
	
	# Update The Score
	points += 1
	$PointSound.pitch_scale += 0.01
	
	$"../../HUD".update_score(points)
	_update_light()
	
	if !$PointSound.playing:
		$PointSound.play()
	
	emit_signal("point")


func _update_light():
	if global.difficulty == 1:
#		light2d.energy += (winning_energy - 0.8)/8
#		light2d.texture_scale += (6.3 - 0.8)/8
		
		updated_energy += (winning_energy - 0.8)/8
		updated_texture_scale += (6.3 - 0.8)/8
		
		
	elif global.difficulty == 2:
#		light2d.energy += (winning_energy - 0.8)/14
#		light2d.texture_scale += (6.3 - 0.8)/14
		
		updated_energy += (winning_energy - 0.8)/14
		updated_texture_scale += (6.3 - 0.8)/14
	
	elif global.difficulty == 3:
#		light2d.energy += (winning_energy - 0.8)/17
#		light2d.texture_scale += (6.3 - 0.8)/17
		
		updated_energy += (winning_energy - 0.8)/17
		updated_texture_scale += (6.3 - 0.8)/17
	
	else:
		updated_energy += 0.005
		updated_texture_scale += 0.03
	
	if light2d.energy >= winning_energy && global.difficulty <= 3:
#		light2d.energy = winning_energy + 0.2
#		light2d.texture_scale = 6.5
		
		updated_energy = winning_energy + 0.2
		updated_texture_scale = 6.5
		emit_signal("win")
	

