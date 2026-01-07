@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("BackgroundSimplifier", "Node", preload("background_simplifier.gd"), preload("icons/background_simplifier_icon.svg"))
	add_custom_type("ComplexAnimatedSprite2D", "AnimatedSprite2D", preload("complex_animated_sprite_2D.gd"), preload("res://icon.svg"))


func _exit_tree() -> void:
	remove_custom_type("BackgroundSimplifier")
	remove_custom_type("ComplexAnimatedSprite2D")
