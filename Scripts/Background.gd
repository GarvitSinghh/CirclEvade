extends Node2D


func _process(delta):
	$Background.modulate.h += delta * 0.1

	global.h = $Background.modulate.h


func _on_circlspin_pressed():
	pass # Replace with function body.
