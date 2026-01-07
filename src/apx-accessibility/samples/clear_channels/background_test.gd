extends Node2D

@onready var background_simplifier: Node = $BackgroundSimplifier
var current: bool = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			current = !current
			background_simplifier.mock_complex_changed(current)
	
