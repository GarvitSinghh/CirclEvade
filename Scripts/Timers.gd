extends Node

signal spawn_enemy
signal spawn_bonus

func _ready():
	connect("spawn_enemy", get_parent(), "_on_EnemyTimer_timeout")
	connect("spawn_bonus", get_parent(), "_on_BonusTimer_timeout")
	
	if global.difficulty < 4:
		$EnemTimer.wait_time = 1.25 - global.difficulty * 0.25
		$BonuTimer.wait_time = 2 + global.difficulty * 0.5
	else:
		$EnemTimer.wait_time = 1.25
		$BonuTimer.wait_time = 2.25
	
	# Hacks
#	$BonuTimer.wait_time = 0.5
#	$EnemTimer.wait_time = 0.3
	
	$EnemTimer.stop()
	$BonuTimer.stop()

func _update_timers():
#	print($EnemTimer.wait_time)
#	print($BonuTimer.wait_time)
	if global.difficulty > 3:
		if $EnemTimer.wait_time >= 0.5:
			$EnemTimer.wait_time -= $EnemTimer.wait_time * 0.01
		else:
			$EnemTimer.wait_time -= 0.0001
			
		if $BonuTimer.wait_time <= 6:
			$BonuTimer.wait_time += $BonuTimer.wait_time * 0.01
		else:
			$BonuTimer.wait_time += 0.0001
	
func _start_enem_timer():
	if global.difficulty > 3:
		$EnemTimer.wait_time = 1.25
	$EnemTimer.start()
	#print("Enem Timer Started")
	
func _stop_enem_timer():
	$EnemTimer.stop()
	#print("Enem Timer Stopped")

func _stop_bonu_timer():
	$BonuTimer.stop()
	#print("Bonu Timer Stopped")

func _start_bonu_timer():
	$BonuTimer.start()
	#print("Bonu Timer Started")
	
func _on_EnemTimer_timeout():
	emit_signal("spawn_enemy")


func _on_BonuTimer_timeout():
	emit_signal("spawn_bonus")
