@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("BackgroundSimplifier", "Node", preload("background_simplifier.gd"), preload("icons/BackgroundSimplifier.svg"))
	add_custom_type("SimplifiableAnimatedSprite2D", "AnimatedSprite2D", preload("simplifiable_animated_sprite_2D.gd"), preload("icons/CustomSprite2D.svg"))
	add_custom_type("SimplifiableSprite2D", "Sprite2D", preload("simplifiable_sprite.gd"), preload("icons/CustomSprite2D.svg"))
	

func _exit_tree() -> void:
	remove_custom_type("BackgroundSimplifier")
	remove_custom_type("SimplifiableAnimatedSprite2D")
	remove_custom_type("SimplifiableSprite2D")
