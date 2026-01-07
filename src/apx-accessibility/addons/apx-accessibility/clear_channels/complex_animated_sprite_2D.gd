@tool
extends AnimatedSprite2D
class_name ComplexAnimatedSprite2D

@export_category("Visual Complexity")
@export var frame_to_use_for_static: int = 0
@export var autoplay_if_static_turned_off: bool = true
var animation_to_use_for_static: String

# fetch animations from sprite frames resource and store it to "animation_to_use_for_static"
func _get_property_list():
	var properties = []
	var animation_names = ""
	if sprite_frames:
		var names = sprite_frames.get_animation_names()
		animation_names = ",".join(names)
	# manually register variable to Godot
	properties.append({
		"name": "animation_to_use_for_static",
		"type": TYPE_STRING,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": animation_names
	})
	return properties

# update if new SpriteFrames is used 
func _set(property, value):
	if property == "sprite_frames":
		sprite_frames = value
		notify_property_list_changed()
		return true
	return false


func _on_reduce_complexity_changed(new_reduce_complexity: bool) -> void:
	if new_reduce_complexity:
		_change_to_static_sprite()
	else:
		_change_to_animated_sprite()


func _change_to_static_sprite() -> void:
	stop()
	frame = frame_to_use_for_static

func _change_to_animated_sprite() -> void:
	animation = animation_to_use_for_static
	if autoplay_if_static_turned_off:
		play()
