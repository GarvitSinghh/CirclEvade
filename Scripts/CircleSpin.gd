extends "res://Scripts/Game.gd"

func _ready():
	$HUD/InstructionLabel.text = "Hold to Turn"
	$HUD/InstructionLabel.show()
	global.gravity = -1
	
	if global.difficulty <= 3:
		$Timers/EnemTimer.wait_time -= 0.02


func _on_HUD_restart():
	$Timers._start_bonu_timer()
	
	$HUD.update_score(0)
	
	$HUD/EvadeLabel.show()
	yield(get_tree().create_timer(1.5), "timeout")
	$HUD/EvadeLabel.hide()
	
	$Timers._start_enem_timer()
	$"Circle Player"._reset_speed()
	$"Circle Player/Player".start()
