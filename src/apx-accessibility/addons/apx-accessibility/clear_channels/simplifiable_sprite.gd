@icon("icons/CustomSprite2D.svg")
extends Sprite2D
class_name SimplifiableSprite2D

@export_category("Visual Complexity")
@export var simplified_texture: Texture2D

var original_texture: Texture2D

func _ready() -> void:
	original_texture = texture


func update_texture(use_simplified_version: bool) -> void:
	texture = simplified_texture if use_simplified_version else original_texture
