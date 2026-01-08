@tool
@icon("icons/ComplexAnimatedSprite2D.svg")
extends Sprite2D
class_name SimplifiableSprite2D

@export_category("Visual Complexity")
@export var simplified_texture: Texture2D

var original_texture: Texture2D

func _ready() -> void:
	original_texture = texture


func update_textures(use_complex: bool) -> void:
	original_texture = texture
	texture = original_texture if use_complex else simplified_texture
