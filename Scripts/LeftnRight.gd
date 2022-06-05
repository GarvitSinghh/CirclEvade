extends "res://Scripts/Game.gd"

func _ready():

	$HUD/InstructionLabel.text = "Tap to Turn"
	$HUD/InstructionLabel.show()
	
	$Timers/EnemTimer.wait_time += 0.3
	global.gravity = 1
	
func _on_HUD_restart():
	$Timers._start_bonu_timer()
	$HUD.update_score(0)
	
	$HUD/EvadeLabel.show()
	yield(get_tree().create_timer(1.5), "timeout")
	$HUD/EvadeLabel.hide()
	
	$Timers._start_enem_timer()
	$"Left Right Player/Player".start()
	
