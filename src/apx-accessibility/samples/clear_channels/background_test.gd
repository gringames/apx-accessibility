extends Node2D

@onready var background_simplifier: Node = $BackgroundSimplifier
@onready var complex_animated_sprit_2d: ComplexAnimatedSprit2D = $ComplexAnimatedSprit2D

var current: bool = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			current = !current
			background_simplifier.on_reduce_complexity_changed(current)
			complex_animated_sprit_2d._on_reduce_complexity_changed(current)
