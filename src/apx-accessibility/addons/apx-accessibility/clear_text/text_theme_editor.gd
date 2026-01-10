@icon("icons/text_configurator.svg")
extends Control
class_name TextThemeEditor

@export var preview_text: Label

@export_group("Constraints")
@export var min_size: float = 10
@export var max_size: float = 100

@export_group("Fonts")
@export var fonts: Array[Font]


func _on_font_color_changed(color: Color) -> void:
	preview_text.add_theme_color_override("font_color", color)


func _on_background_color_changed(color: Color) -> void:
	print("change background color to ", str(color))
