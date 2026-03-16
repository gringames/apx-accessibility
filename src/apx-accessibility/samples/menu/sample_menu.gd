extends Control

@onready var visibility_reduction_check_button: CheckButton = $CanvasLayer/Panel/VBoxContainer/HBoxContainer/CheckButton

func _ready() -> void:
	visibility_reduction_check_button.toggled.connect(_notify_settings)

func _notify_settings(toggled_on: bool) -> void:
	GlobalSettings.visibility_reduction_toggled.emit(toggled_on)
