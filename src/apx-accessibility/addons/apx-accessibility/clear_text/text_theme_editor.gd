@icon("icons/text_configurator.svg")
extends Control
class_name TextThemeEditor

@export var preview_text: Label
@export var theme_to_edit: Theme

@export_group("Constraints")
@export var min_size: float = 10
@export var max_size: float = 100

@export_group("Fonts")
@export var fonts: Array[Font]

var style_box: StyleBoxFlat = StyleBoxFlat.new()


func _on_font_color_changed(color: Color) -> void:
	preview_text.add_theme_color_override("font_color", color)
	theme_to_edit.set_color("font_color", "Label", color)


func _on_background_color_changed(color: Color) -> void:
	style_box.bg_color = color
	preview_text.add_theme_stylebox_override("normal", style_box)
