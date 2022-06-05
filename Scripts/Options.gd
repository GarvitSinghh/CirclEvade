extends Node2D
signal options_closed


func _ready():
	$OptionLayer/OptionsController/DifficultySlider.value = global.difficulty
	connect("options_closed", get_parent(), "_on_options_closed")
	connect("options_closed", get_parent().get_parent(), "_on_options_closed")




func _on_DifficultySlider_value_changed(value):
	global.difficulty = value


func _on_Button_pressed():
	queue_free()
	emit_signal("options_closed")
