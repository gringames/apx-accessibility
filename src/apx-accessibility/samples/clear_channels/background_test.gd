extends Node2D

@onready var background_simplifier: BackgroundSimplifier = $BackgroundSimplifier
@onready var background_empty: SimplifiableSprite2D = $Background
@onready var player: SimplifiableAnimatedSprite2D = $Player

var current: bool = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			current = !current
			background_simplifier.update_complex_node_visibility(current)
			background_empty.update_texture(current)
			player.update_animation(current)
