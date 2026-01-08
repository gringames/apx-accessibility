@tool
@icon("icons/ControlsReminder.svg")
extends Sprite2D
class_name ControlsReminder

const BACKGROUND_BOX_NAME: String = "BackgroundColor"

@export var add_background_box: bool = false:
	set(value):
		add_background_box = value
		notify_property_list_changed()
		
var background_box_color: Color = Color(0, 0, 0, 0.8)
var background_box_size: Vector2 = Vector2i(1500, 900)

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []

	var usage = PROPERTY_USAGE_DEFAULT
	if not add_background_box:
		usage = PROPERTY_USAGE_READ_ONLY | PROPERTY_USAGE_EDITOR
	
	properties.append({
		"name": "background_box_size",
		"type": TYPE_VECTOR2,
		"usage": usage
	})
	
	properties.append({
		"name": "background_box_color",
		"type": TYPE_COLOR,
		"usage": usage
	})
	
	return properties

func _ready() -> void:
	if add_background_box:
		_add_background_box_with_color()
	hide_controls()

func _add_background_box_with_color() -> void:
	var color_rect: ColorRect = ColorRect.new()
	color_rect.name = BACKGROUND_BOX_NAME
	color_rect.size = background_box_size
	color_rect.color = background_box_color
	color_rect.position = background_box_size / -2
	color_rect.show_behind_parent = true
	add_child(color_rect)

func hide_controls() -> void:
	hide()

func show_controls() -> void:
	show()
