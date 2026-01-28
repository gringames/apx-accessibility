extends HBoxContainer
class_name ObjectiveContent

@export var stand_in_image: Texture2D

@onready var content_image: TextureRect = $ContentImage
@onready var content_title: Label = $"VBoxContainer Texts/ContentTitle"
@onready var content_description: Label = $"VBoxContainer Texts/ContentDescription"


func _ready() -> void:
	pass
	# TODO: use stand ins / create empty representation

func update_contents(title: String, description: String, image_path: String = "") -> void:
	content_title.text = title
	content_description.text = description
	# TODO: update image as well
	# if image_path != "":
	# 	content_image.texture = ??
