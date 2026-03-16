@tool
@icon("res://addons/clear_channels/icons/CustomSprite2D.svg")
extends AnimatedSprite2D
class_name SimplifiableAnimatedSprite2D

@export_category("Visual Complexity")
@export var autoplay_if_static_turned_off: bool = true
var visual_reduction_on: bool = false
var frame_to_use_for_static: int = 0
var animation_to_use_for_static: String:
	set(value):
		animation_to_use_for_static = value
		frame_to_use_for_static = 0 
		notify_property_list_changed()

# fetch data from sprite frames resource
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
	
	var frame_options = ""
	var frame_max = 0
	if sprite_frames and sprite_frames.has_animation(animation_to_use_for_static):
		var count = sprite_frames.get_frame_count(animation_to_use_for_static)
		frame_max = count - 1
	properties.append({
		"name": "frame_to_use_for_static",
		"type": TYPE_INT,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0," + str(frame_max) + ",1"
	})
	return properties

# update if new SpriteFrames is used 
func _set(property, value):
	if property == "sprite_frames":
		sprite_frames = value
		notify_property_list_changed()
		return true
	return false


func _ready() -> void:
	if not Engine.is_editor_hint():
		animation_changed.connect(_on_anim_changed)
		VisibilityReductionSettings.visibility_reduction_toggled.connect(update_animation)

func _on_anim_changed() -> void:
	update_animation.call_deferred(visual_reduction_on)

func update_animation(use_simplified_version: bool) -> void:
	visual_reduction_on = use_simplified_version
	if use_simplified_version:
		_change_to_static_sprite()
	else:
		_change_to_animated_sprite()


func _change_to_static_sprite() -> void:
	if animation_to_use_for_static != animation_to_use_for_static:
		animation = animation_to_use_for_static
	stop()
	frame = frame_to_use_for_static

func _change_to_animated_sprite() -> void:
	if autoplay_if_static_turned_off:
		play()
