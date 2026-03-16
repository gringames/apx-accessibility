extends Control

@onready var visibility_reduction_check_button: CheckButton = $Panel/HBoxContainer/CheckButton

func _ready() -> void:
	visibility_reduction_check_button.toggled.connect(_notify_settings)

func _notify_settings(toggled_on: bool) -> void:
	VisibilityReductionSettings.toggle_visibility_reduction(toggled_on)
