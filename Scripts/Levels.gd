extends Node2D

onready var endless_btn = $"CanvasLayer/MarginContainer/CenterContainer/VBoxContainer/Difficulty Container/VBoxContainer/Endless"
var selected_level : int = 0

onready var spinlvl_btn = $"CanvasLayer/MarginContainer/CenterContainer/VBoxContainer/LevelsContainer/CenterContainer/HBoxContainer/Level2"
onready var slidelvl_btn = $"CanvasLayer/MarginContainer/CenterContainer/VBoxContainer/LevelsContainer/CenterContainer/HBoxContainer/Level1"

onready var clearedlvl1 = $CanvasLayer/MarginContainer/CenterContainer/VBoxContainer/LevelsContainer/CenterContainer/HBoxContainer/Level1/ClearedLvl1
onready var clearedlvl2 = $CanvasLayer/MarginContainer/CenterContainer/VBoxContainer/LevelsContainer/CenterContainer/HBoxContainer/Level2/ClearedLvl2


func _ready():
	
	clearedlvl1.hide()
	clearedlvl2.hide()

	if global.difficulty != 4:
		var score_file = "user://levels.save"
		var f = File.new()
		var level1: bool = false
		var level2: bool = false

		if f.file_exists(score_file):
			f.open(score_file, File.READ)
			level1 = f.get_var()
			level2 = f.get_var()
			if level1:
				clearedlvl1.show()
			if level2:
				clearedlvl2.show()
			f.close()

func _process(delta):
	endless_btn.modulate.h += delta


func _on_Level1_toggled(button_pressed):

	if button_pressed:
		selected_level = 1
		spinlvl_btn.pressed = false
	


func _on_Level2_toggled(button_pressed):
	if !button_pressed:
		endless_btn.hide()
	
	if button_pressed:
		slidelvl_btn.pressed = false
		selected_level = 2
		endless_btn.show()	
		


func _on_Easy_pressed():
	global.difficulty = 1
	if selected_level == 1:
		get_tree().change_scene("res://Scenes/LeftnRight.tscn")
	elif selected_level == 2:
		get_tree().change_scene("res://Scenes/CircleSpin.tscn")


func _on_Medium_pressed():
	global.difficulty = 2
	if selected_level == 1:
		get_tree().change_scene("res://Scenes/LeftnRight.tscn")
	elif selected_level == 2:
		get_tree().change_scene("res://Scenes/CircleSpin.tscn")


func _on_Hard_pressed():
	global.difficulty = 3
	
	if selected_level == 1:
		get_tree().change_scene("res://Scenes/LeftnRight.tscn")
	elif selected_level == 2:
		get_tree().change_scene("res://Scenes/CircleSpin.tscn")


func _on_Endless_pressed():
	global.difficulty = 4
	
	get_tree().change_scene("res://Scenes/CircleSpin.tscn")


func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
