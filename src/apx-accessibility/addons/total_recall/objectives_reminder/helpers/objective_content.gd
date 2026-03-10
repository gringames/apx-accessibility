extends HBoxContainer
class_name ObjectiveContent

@export var stand_in_image: Texture2D

@onready var content_image: TextureRect = $ContentImage
@onready var content_title: Label = $"VBoxContainer Texts/ContentTitle"
@onready var content_description: Label = $"VBoxContainer Texts/ContentDescription"


func update_contents(title: String, description: String, image_path: String = "") -> void:
	content_title.text = title
	content_description.text = description
	if image_path != "":
		_set_content_image_texture(load(image_path))
	else:
		_set_content_image_texture(stand_in_image)

func _set_content_image_texture(texture: Texture2D) -> void:
	content_image.texture = texture
