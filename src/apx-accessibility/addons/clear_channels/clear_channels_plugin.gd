@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("VisualSimplifier", "Node", preload("visual_simplifier/visual_simplifier.gd"), preload("icons/VisualSimplifier.svg"))
	add_custom_type("SimplifiableAnimatedSprite2D", "AnimatedSprite2D", preload("simplifiable_sprites/simplifiable_animated_sprite_2D.gd"), preload("icons/CustomSprite2D.svg"))
	add_custom_type("SimplifiableSprite2D", "Sprite2D", preload("simplifiable_sprites/simplifiable_sprite.gd"), preload("icons/CustomSprite2D.svg"))
	

func _exit_tree() -> void:
	remove_custom_type("VisualSimplifier")
	remove_custom_type("SimplifiableAnimatedSprite2D")
	remove_custom_type("SimplifiableSprite2D")

func _enable_plugin() -> void:
	add_autoload_singleton("VisibilityReductionSettings", "res://addons/clear_channels/visibility_reduction_settings.gd")

func _disable_plugin() -> void:
	remove_autoload_singleton("VisibilityReductionSettings")
