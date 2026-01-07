@tool
extends AnimatedSprite2D
class_name ComplexAnimatedSprite2D

@export_category("Visual Complexity")
@export var frame_to_use_for_static: int = 0
@export var autoplay_if_static_turned_off: bool = true


func _on_reduce_complexity_changed(new_reduce_complexity: bool) -> void:
	if new_reduce_complexity:
		_change_to_static_sprite()
	else:
		_change_to_animated_sprite()


func _change_to_static_sprite() -> void:
	stop()
	frame = frame_to_use_for_static

func _change_to_animated_sprite() -> void:
	if autoplay_if_static_turned_off:
		play()
