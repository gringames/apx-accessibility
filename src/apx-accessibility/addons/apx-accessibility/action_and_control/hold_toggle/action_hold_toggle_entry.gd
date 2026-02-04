extends HBoxContainer
class_name ActionHoldToggleEntry

signal toggle_changed(action_name: String, toggled_on: bool)

@onready var action_name_label: Label = $ActionName
@onready var toggle_check_button: CheckButton = $ToggleCheckButton

var action_name: String

func _ready() -> void:
	toggle_check_button.toggled.connect(_on_toggle_changed)

func set_action_name(new_action_name: String) -> void:
	action_name = new_action_name
	action_name_label.text = action_name

func set_hold_toggle(toggled_on: bool) -> void:
	toggle_check_button.button_pressed = toggled_on

func _on_toggle_changed(toggled_on: bool) -> void:
	toggle_changed.emit(action_name, toggled_on)
