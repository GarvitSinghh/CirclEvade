extends Control

func _ready():
	pass

func _on_StartButton_pressed():
	if !$ButtonPress.playing:
		$ButtonPress.play()
	get_tree().change_scene("res://Scenes/Levels.tscn")


func _on_OptionsButton_pressed():
	if !$ButtonPress.playing:
		$ButtonPress.play()
	
	var options_scene = load("res://Scenes/Options.tscn")
	for i in $CanvasLayer.get_children():
		i.hide()
	var options = options_scene.instance()
	add_child(options)


func _on_QuitButton_pressed():
	if !$ButtonPress.playing:
		$ButtonPress.play()
	
	get_tree().quit()

func _on_options_closed():
	if !$ButtonPress.playing:
		$ButtonPress.play()
	
	for i in $CanvasLayer.get_children():
		i.show()


func _on_EndlessBtn_pressed():
	global.difficulty = 4
	get_tree().change_scene("res://Scenes/CircleSpin.tscn")
