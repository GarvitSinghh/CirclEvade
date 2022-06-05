extends CanvasLayer

signal restart
export (PackedScene) var Explosion

onready var evade_label = $EvadeLabel
onready var progress_bar = $ScoreProgress
#onready var restart_btn = $RestartButton
#onready var back_btn = $BackButton
onready var buttons = $Buttons
onready var score = $Score

func _ready():
	connect("restart", get_parent(), '_on_HUD_restart')
	progress_bar.value = 0
	progress_bar.show()	
	score.text = "0"
	score.hide()
	
	if global.difficulty == 1:
		progress_bar.max_value = 9
		
	elif global.difficulty == 2:
		progress_bar.max_value = 15
	
	elif global.difficulty == 3:
		progress_bar.max_value = 18
	
	elif global.difficulty == 4:
		progress_bar.hide()
		score.show()
		
	
#	restart_btn.hide()
#	back_btn.hide()
	buttons.hide()
	$InstructionLabel.hide()
	$Highscore.hide()
	

func _show_highscore():
	$Highscore.show()
	$HighScoreAnmation.play("Animation")

func update_score(points):
	progress_bar.value += 1
	score.text = str(points)
	

func show_win():
	evade_label.show()
	evade_label.text = "You Win"
	evade_label.modulate = "000000"
	$BackButton2.show()

	
	if global.difficulty < 4:
		progress_bar.hide()
	else:
		score.hide()
	
	
func show_restart():
	evade_label.hide()
	$InstructionLabel.hide()
#	restart_btn.show()
#	back_btn.show()
	buttons.show()


func _on_EvadeLabelTimer_timeout():
	evade_label.hide()


func _on_Button_pressed():
#	restart_btn.hide()
#	back_btn.hide()
	buttons.hide()
	if !$ButtonPress.playing:
		$ButtonPress.play()
	
	if global.difficulty < 4:
		progress_bar.show()
	
	else: 
		score.show()

	emit_signal("restart")
	$Highscore.hide()
	global.previous_velocity = 0
	
	progress_bar.value = 0


func _on_BackButton_pressed():
	if !$ButtonPress.playing:
		$ButtonPress.play()
	
	get_tree().change_scene("res://Scenes/Levels.tscn")
