@icon("res://addons/apx-accessibility/action_and_control/icons/HoldToggleSettings.svg")
extends Control
class_name ActionHoldSettings

@export var capitalize_display_names: bool = true
@export var input_action_names: Array[ActionWithDisplayName] = []
@export var action_hold_entry_template: PackedScene

@onready var vbox: VBoxContainer = $VBoxContainer

func _ready() -> void:
	if input_action_names.is_empty(): return
	for action_with_display_name in input_action_names:
		var action_name: String = action_with_display_name.action_name
		var action_display_name: String = action_with_display_name.display_name
		InputHoldToggleManager.add_action(action_name)
		_add_action_to_settings(action_name, action_display_name)


func _add_action_to_settings(action_name: String, action_display_name: String = "") -> void:
	var entry: ActionHoldToggleEntry = action_hold_entry_template.instantiate()
	vbox.add_child(entry)
	var display_name: String = _get_display_name(action_name, action_display_name)
	var toggled: bool = _input_mode_to_toggled(InputHoldToggleManager.get_action_input_mode(action_name))
	entry.set_action_name(action_name)
	entry.set_display_name(display_name)
	entry.set_hold_toggle(toggled)
	entry.toggle_changed.connect(_on_action_toggle_changed)

func _get_display_name(action_name: String, action_display_name: String) -> String:
	var display_name: String = action_name if action_display_name == "" else action_display_name
	if capitalize_display_names:
		display_name = display_name.capitalize()
	return display_name

func _on_action_toggle_changed(action_name: String, toggled_on: bool) -> void:
	InputHoldToggleManager.update_action(action_name, _get_input_mode(toggled_on))


func _get_input_mode(toggled_on: bool) -> InputMode.Type:
	if toggled_on: return InputMode.Type.Toggle
	return InputMode.Type.Hold

func _input_mode_to_toggled(mode: InputMode.Type) -> bool:
	return mode == InputMode.Type.Toggle
