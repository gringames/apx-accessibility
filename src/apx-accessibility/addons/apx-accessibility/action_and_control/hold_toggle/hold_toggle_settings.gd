extends Control
class_name ActionHoldSettings

@export var input_action_names: Array[String] = []
@export var action_hold_entry_template: PackedScene
@onready var vbox: VBoxContainer = $VBoxContainer

func _ready() -> void:
	if input_action_names.is_empty(): return
	for action_name in input_action_names:
		InputHoldToggleManager.add_action(action_name)
		_add_action_to_settings(action_name)


func _add_action_to_settings(action_name: String) -> void:
	var entry: ActionHoldToggleEntry = action_hold_entry_template.instantiate()
	vbox.add_child(entry)
	entry.set_action_name(action_name)
	var toggled: bool = _input_mode_to_toggled(InputHoldToggleManager.get_action_input_mode(action_name))
	entry.set_hold_toggle(toggled)
	entry.toggle_changed.connect(_on_action_toggle_changed)

func _on_action_toggle_changed(action_name: String, toggled_on: bool) -> void:
	InputHoldToggleManager.update_action(action_name, _get_input_mode(toggled_on))


func _get_input_mode(toggled_on: bool) -> InputMode.Type:
	if toggled_on: return InputMode.Type.Toggle
	return InputMode.Type.Hold

func _input_mode_to_toggled(mode: InputMode.Type) -> bool:
	return mode == InputMode.Type.Toggle
