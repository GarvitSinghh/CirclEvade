extends Node2D

export (PackedScene) var enemy_scene = load("res://Scenes/Characters/Enemy.tscn")
export (PackedScene) var bonus_scene = load("res://Scenes/Characters/Bonus.tscn")
export (PackedScene) var enemy_explosion = load("res://Scenes/Effects/DarkExplosion.tscn")
export (PackedScene) var bonus_explosion = load("res://Scenes/Effects/BonusEffect.tscn")

var first_run = true

func _ready():
	randomize()
	$Background/Background.modulate.h = global.h
	
	$Timers._stop_enem_timer()
	$Timers._stop_bonu_timer()
	
func _unhandled_input(event):
	if event is InputEventScreenTouch and first_run:
		first_run = false
		$Timers._start_enem_timer()
		$Timers._start_bonu_timer()
		yield(get_tree().create_timer(1), "timeout")
		$HUD/InstructionLabel.hide()
		global.started = true
		$HUD/EvadeLabel.show()
		yield(get_tree().create_timer(2), "timeout")
		$HUD/EvadeLabel.hide()
		
	

func new_game():
	$Player.points = 0
	$Player.start()
	$Timers._start_enem_timer()
	$Timers._start_bonu_timer()


func game_over():
	$Timers._stop_enem_timer()
	$Timers._stop_bonu_timer()


func _on_EnemyTimer_timeout():
	var enemy = enemy_scene.instance()
	add_child(enemy)
	var spawn_location = $EnemSpawnPath/EnemSpawnLocation
	spawn_location.unit_offset = rand_range(0, 1.1)
	enemy.position = spawn_location.position
	



func _on_BonusTimer_timeout():
	
	var bonus = bonus_scene.instance()
	add_child(bonus)
	bonus.scale = Vector2(0.2, 0.2)


func _on_Player_hit():
	game_over()
	if global.difficulty == 4:
		var score_file = "user://score.save"
		var f = File.new()
		var highscore: int = 0

		if f.file_exists(score_file):
			f.open(score_file, File.READ)
			highscore = f.get_var()
			print(highscore)
			f.close()

			if int($HUD/Score.text) > highscore:
				f.open(score_file, File.WRITE)
				highscore = int($HUD/Score.text)
				f.store_var(highscore)
				f.close()

				$HUD._show_highscore()
				$NewBest.play()

		else:
			f.open(score_file, File.WRITE)
			print(f)
			highscore = int($HUD/Score.text)
			f.store_var(highscore)
			f.close()
		
	$HUD.show_restart()
	

func _on_Player_win():
	var deletions = []
	$Timers._stop_enem_timer()
	$Timers._stop_bonu_timer()
	for i in get_children():
		if "Enemy" in i.name:
			var explosion = enemy_explosion.instance()
			add_child(explosion)
			explosion.rotation_degrees = i.velocity.x + i.velocity.y
			explosion.position = i.position
			deletions.append(i)
		
		elif "Bonus" in i.name:
			var explosion = bonus_explosion.instance()
			add_child(explosion)
			explosion.position = i.position
			deletions.append(i)
	
	for i in deletions:
		i.queue_free()
	
	$HUD.show_win()
	$NewBest.play()



