@tool
extends AnimationPlayer
class_name SimplifiableAnimationPlayer

@export var autoplay_if_static_turned_off: bool = true
var visual_reduction_on: bool = false
var animation_to_use_for_static: String:
	set(value):
		animation_to_use_for_static = value
		notify_property_list_changed()

# fetch data from animation resource
func _get_property_list():
	var properties = []
	var animation_names = ""
	var names = get_animation_list()
	animation_names = ",".join(names)
	# manually register variable to Godot
	properties.append({
		"name": "animation_to_use_for_static",
		"type": TYPE_STRING_NAME,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": animation_names
	})
	return properties

func _ready() -> void:
	if not Engine.is_editor_hint():
		current_animation_changed.connect(_on_anim_changed)
		VisibilityReductionSettings.visibility_reduction_toggled.connect(_update_animation)


func _update_animation(use_simple: bool) -> void:
	visual_reduction_on = use_simple
	if use_simple:
		if current_animation != animation_to_use_for_static:
			current_animation = animation_to_use_for_static
		stop()


func _on_anim_changed(new_anim: String) -> void:
	if new_anim == animation_to_use_for_static or new_anim == "":
		return
	_update_animation.call_deferred(visual_reduction_on)
