@icon("icons/text_configurator.svg")
extends Control
class_name TextThemeEditor

## CONSTANTS
const THEME_TYPE_LABEL: String = "Label"

## WCAG CONSTANTS
const LUMINANCE_THRESHOLD: float = 0.179

## READY VARIABLES
@onready var font_size_spin_box: SpinBox = $"VBoxContainer/HBoxContainer (Font Size)/SpinBox"
@onready var line_spacing_spin_box: SpinBox = $"VBoxContainer/HBoxContainer (Font VSpacing)/SpinBox"
@onready var h_box_container_contrast: HBoxContainer = $"VBoxContainer/HBoxContainer (Contrast)"
@onready var contrast_check_button: CheckButton = $"VBoxContainer/HBoxContainer (Contrast)/ContrastCheckButton"
@onready var font_color_picker_button: ColorPickerButton = $"VBoxContainer/HBoxContainer (Font Color)/ColorPickerButton"
@onready var background_color_picker_button: ColorPickerButton = $"VBoxContainer/HBoxContainer (Back Color)/ColorPickerButton"
@onready var font_option_button: OptionButton = $"VBoxContainer/HBoxContainer (Fonts)/OptionButton"
@onready var h_box_container_fonts_: HBoxContainer = $"VBoxContainer/HBoxContainer (Fonts)"
@onready var back_margins_spin_box: SpinBox = $"VBoxContainer/HBoxContainer (Back Margins)/SpinBox"
@onready var preview_text: Label = $PreviewLabel

## EXPORT VARS
@export_group("Theme")
@export var theme_to_edit: Theme

@export_group("Preview Text")
@export_multiline var text_for_preview: String = "Preview Text\nThis is a second line"

@export_group("Constraints")
@export var min_font_size: float = 10
@export var max_font_size: float = 140
@export var min_line_spacing: float = 0
@export var max_line_spacing: float = 15
@export var min_margins: float = 0
@export var max_margins: float = 10

@export_group("Fonts")
@export var allow_font_changes: bool = true
@export var fonts: Array[Font] = []

@export_group("Contrast")
@export var add_contrast_button: bool = true
@export_enum("WCAG2", "APCA") var contrast_method

## REGULAR VARIABLES
var style_box: StyleBoxFlat = StyleBoxFlat.new()
var font_name_to_index: Dictionary[String, int] = {"Open Sans SemiBold":-1}
var auto_contrast_enabled: bool = false


## SETUP
func _ready() -> void:
	preview_text.theme = theme_to_edit
	preview_text.text = text_for_preview
	_remove_font_options_if_not_checked()
	_remove_contrast_button_if_not_checked()
	_setup_default_values()

func _remove_font_options_if_not_checked() -> void:
	if fonts.is_empty() or not allow_font_changes:
		printerr("[TextThemeEditor] no fonts specified, removing from editor!")
		h_box_container_fonts_.queue_free()
		allow_font_changes = false

func _remove_contrast_button_if_not_checked() -> void:
	if not add_contrast_button:
		h_box_container_contrast.queue_free()

func _setup_default_values() -> void:
	_set_spin_box_values(font_size_spin_box, min_font_size, max_font_size, theme_to_edit.get_font_size("font_size", THEME_TYPE_LABEL))
	_set_spin_box_values(line_spacing_spin_box, min_line_spacing, max_line_spacing, theme_to_edit.get_constant("line_spacing", THEME_TYPE_LABEL))
	_set_spin_box_values(back_margins_spin_box, min_margins, max_margins, _get_theme_margins())
	_set_color_button_color(font_color_picker_button, theme_to_edit.get_color("font_color", THEME_TYPE_LABEL))
	_set_color_button_color(background_color_picker_button, _get_theme_background_color())
	_prepare_font_dropdown()

func _set_spin_box_values(spin_box: SpinBox, min: float, max: float, default: float) -> void:
	spin_box.min_value = min
	spin_box.max_value = max
	spin_box.value = default

func _get_theme_margins() -> int:
	var style_box: StyleBox = theme_to_edit.get_stylebox("normal", THEME_TYPE_LABEL)
	return style_box.get_margin(SIDE_BOTTOM)

func _set_color_button_color(color_button: ColorPickerButton, color: Color) -> void:
	color_button.color = color
	color_button.get_picker().presets_visible = false

func _get_theme_background_color() -> Color:
	var style_box: StyleBox = theme_to_edit.get_stylebox("normal", THEME_TYPE_LABEL)
	if style_box is not StyleBoxFlat:
		return Color(0,0,0,0)
	style_box = style_box as StyleBoxFlat
	return style_box.bg_color

func _prepare_font_dropdown() -> void:
	if not allow_font_changes: return
	for i in range(fonts.size()):
		var font_name: String = fonts[i].get_font_name()
		font_option_button.add_item(font_name, i)
		font_name_to_index[font_name] = i
	var theme_font_name: String = theme_to_edit.get_font("font", THEME_TYPE_LABEL).get_font_name()
	font_option_button.selected = font_name_to_index[theme_font_name]



## ON VALUE CHANGE EVENTS

func _on_contrast_check_button_toggled(toggled_on: bool) -> void:
	auto_contrast_enabled = toggled_on


func _on_font_color_changed(color: Color) -> void:
	_update_theme_font_color(color)
	if auto_contrast_enabled:
		_set_back_to_best_contrast(color)

func _update_theme_font_color(color: Color) -> void:
	theme_to_edit.set_color("font_color", THEME_TYPE_LABEL, color)

func _on_background_color_changed(color: Color) -> void:
	_update_theme_back_color(color)
	if auto_contrast_enabled:
		_set_text_to_best_contrast(color)

func _update_theme_back_color(color: Color) -> void:
	style_box.bg_color = color
	theme_to_edit.set_stylebox("normal", THEME_TYPE_LABEL, style_box)

# without this, editing color with a = 0 may be confusing for the player
func _on_background_color_picker_button_picker_clicked_first() -> void:
	var style_box: StyleBox = theme_to_edit.get_stylebox("normal", THEME_TYPE_LABEL)
	if style_box is not StyleBoxFlat:
		background_color_picker_button.color.a = 1


func _on_font_size_changed(value: float) -> void:
	var size: int = int(value)
	theme_to_edit.set_font_size("font_size", THEME_TYPE_LABEL, size)


func _on_line_spacing_changed(value: float) -> void:
	var spacing: int = int(value)
	theme_to_edit.set_constant("line_spacing", THEME_TYPE_LABEL, spacing)


func _on_font_selected(index: int) -> void:
	theme_to_edit.set_font("font", THEME_TYPE_LABEL, fonts[index])


func _on_back_margins_changed(value: float) -> void:
	var margins: int = int(value)
	style_box.expand_margin_bottom = margins
	style_box.expand_margin_top = margins
	style_box.expand_margin_left = margins / 2
	style_box.expand_margin_right = margins / 2
	theme_to_edit.set_stylebox("normal", THEME_TYPE_LABEL, style_box)


## CONTRAST HELPERS

func _set_back_to_best_contrast(text_color: Color) -> void:
	var contrast_color: Color = get_best_contrasting_color(text_color)
	background_color_picker_button.color = contrast_color
	_update_theme_back_color(contrast_color)

func _set_text_to_best_contrast(back_color: Color) -> void:
	var contrast_color: Color = get_best_contrasting_color(back_color)
	font_color_picker_button.color = contrast_color
	_update_theme_font_color(contrast_color)


## COLOR CONTRAST CALCULATIONS (WCAG 2.1)

func get_best_contrasting_color(input_color: Color) -> Color:
	var color_luminance = get_luminance(input_color)
	if color_luminance < LUMINANCE_THRESHOLD: return Color.WHITE
	else: return Color.BLACK

func get_luminance(color: Color) -> float:
	var r_linear: float = color_component_to_linear(color.r)
	var g_linear: float = color_component_to_linear(color.g)
	var b_linear: float = color_component_to_linear(color.b)
	# from the definition of luminance
	return 0.2126 * r_linear + 0.7152 * g_linear + 0.0722 * b_linear

func color_component_to_linear(color_component: float) -> float:
	# from sRGB (undo gamma)
	if color_component <= 0.04045:
		return color_component / 12.92
	return ((color_component + 0.055) / 1.055) ** 2.4


## COLOR CONTRAST CALCULATIONS (APCA)
