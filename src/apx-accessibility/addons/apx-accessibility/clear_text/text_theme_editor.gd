@icon("icons/text_configurator.svg")
extends Control
class_name TextThemeEditor

const THEME_TYPE_LABEL: String = "Label"

@onready var font_size_spin_box: SpinBox = $"VBoxContainer/HBoxContainer (Font Size)/SpinBox"
@onready var line_spacing_spin_box: SpinBox = $"VBoxContainer/HBoxContainer (Font VSpacing)/SpinBox"
@onready var font_color_picker_button: ColorPickerButton = $"VBoxContainer/HBoxContainer (Font Color)/ColorPickerButton"
@onready var background_color_picker_button: ColorPickerButton = $"VBoxContainer/HBoxContainer (Back Color)/ColorPickerButton"

@export var preview_text: Label
@export var theme_to_edit: Theme

@export_group("Constraints")
@export var min_font_size: float = 10
@export var max_font_size: float = 140
@export var min_line_spacing: float = 0
@export var max_line_spacing: float = 15

@export_group("Fonts")
@export var fonts: Array[Font]

var style_box: StyleBoxFlat = StyleBoxFlat.new()


func _ready() -> void:
	preview_text.theme = theme_to_edit
	_setup_default_values()


func _setup_default_values() -> void:
	_set_spin_box_values(font_size_spin_box, min_font_size, max_font_size, theme_to_edit.get_font_size("font_size", THEME_TYPE_LABEL))
	_set_spin_box_values(line_spacing_spin_box, min_line_spacing, max_line_spacing, theme_to_edit.get_constant("line_spacing", THEME_TYPE_LABEL))
	_set_color_button_color(font_color_picker_button, theme_to_edit.get_color("font_color", THEME_TYPE_LABEL))
	_set_color_button_color(background_color_picker_button, _get_theme_background_color())
	

func _set_spin_box_values(spin_box: SpinBox, min: float, max: float, default: float) -> void:
	spin_box.min_value = min
	spin_box.max_value = max
	spin_box.value = default

func _set_color_button_color(color_button: ColorPickerButton, color: Color) -> void:
	color_button.color = color

func _get_theme_background_color() -> Color:
	var style_box: StyleBox = theme_to_edit.get_stylebox("normal", THEME_TYPE_LABEL)
	if style_box is not StyleBoxFlat:
		return Color(0,0,0,0)
	style_box = style_box as StyleBoxFlat
	return style_box.bg_color

func _on_font_color_changed(color: Color) -> void:
	theme_to_edit.set_color("font_color", THEME_TYPE_LABEL, color)


func _on_background_color_changed(color: Color) -> void:
	style_box.bg_color = color
	theme_to_edit.set_stylebox("normal", THEME_TYPE_LABEL, style_box)


func _on_font_size_changed(value: float) -> void:
	var size: int = int(value)
	theme_to_edit.set_font_size("font_size", THEME_TYPE_LABEL, size)


func _on_line_spacing_changed(value: float) -> void:
	var spacing: int = int(value)
	theme_to_edit.set_constant("line_spacing", THEME_TYPE_LABEL, spacing)


# without this, editing color with a = 0 may be confusing for the player
func _on_background_color_picker_button_picker_clicked_first() -> void:
	var style_box: StyleBox = theme_to_edit.get_stylebox("normal", THEME_TYPE_LABEL)
	if style_box is not StyleBoxFlat:
		background_color_picker_button.color.a = 1
