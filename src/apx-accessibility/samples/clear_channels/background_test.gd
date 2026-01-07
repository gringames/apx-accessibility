extends Node2D

@onready var background_simplifier: BackgroundSimplifier = $BackgroundSimplifier
@onready var complex_animated_sprite_2d: ComplexAnimatedSprite2D = $ComplexAnimatedSprite2D

var current: bool = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			current = !current
			background_simplifier._on_reduce_complexity_changed(current)
			complex_animated_sprite_2d._on_reduce_complexity_changed(current)
