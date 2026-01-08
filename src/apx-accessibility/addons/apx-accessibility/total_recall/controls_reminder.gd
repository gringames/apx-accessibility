@icon("icons/ControlsReminder.svg")
extends Node
class_name ControlsReminder

@export var sprite: Sprite2D
@export var controls_image: Texture2D

# @export var size: Vector2
# @export var position: Vector2

# TODO: customize appearance even more:
# @export var blur_background: bool = false
# @export var add_background_box: bool = false
# @export var background_box_color: Color = Color.black

# TODO: allow for multiple images depending on control preset
# @export var control_images: Array[Texture2D] # prolly with config resource
# var current_control_image_index: int = 0

# TODO: allow for updating remapped controls

func _ready() -> void:
	sprite.texture = controls_image
	_hide_controls()


func _hide_controls() -> void:
	sprite.hide()

func _show_controls() -> void:
	sprite.show()
