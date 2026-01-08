extends Node2D

@onready var background_simplifier: BackgroundSimplifier = $BackgroundSimplifier

var current: bool = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			current = !current
			background_simplifier._on_reduce_complexity_changed(current)
