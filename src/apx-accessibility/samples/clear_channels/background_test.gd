extends Node2D

@onready var visual_simplifier: VisualSimplifier = $VisualSimplifier
@onready var background_empty: SimplifiableSprite2D = $Background
@onready var player: SimplifiableAnimatedSprite2D = $Player
@onready var controls_reminder: ControlsReminder = $ControlsReminder

var current: bool = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			current = !current
			visual_simplifier.update_complex_node_visibility(current)
			background_empty.update_texture(current)
			player.update_animation(current)
			controls_reminder.call("show_controls" if current else "hide_controls")
