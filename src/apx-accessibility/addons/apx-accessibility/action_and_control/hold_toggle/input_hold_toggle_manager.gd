@icon("res://addons/apx-accessibility/action_and_control/icons/HoldToggleSettings.svg")
extends Node

var actions: Dictionary[String, HoldToggleInputAction] = {}

func _ready() -> void:
	if actions and actions.is_empty():
		set_process(false)


func add_action(action_name: String, mode: InputMode.Type = InputMode.Type.Hold) -> void:
	if !actions.has(action_name):
		actions[action_name] = _make_action(action_name, mode)
	if actions.size() == 1:
		set_process(true)
	print("adding action ", action_name, " with mode ", InputMode.TYPE_TO_STRING[mode])

func remove_action(action_name: String) -> void:
	if actions.has(action_name):
		actions.erase(action_name)
	if actions.is_empty():
		set_process(false)
	print("removing action ", action_name)
	

func update_action(action_name: String, mode: InputMode.Type) -> void:
	if actions.has(action_name):
		actions[action_name].mode = mode
	print("updating action ", action_name, " to mode ", InputMode.TYPE_TO_STRING[mode])

func is_action_active(action_name: String) -> bool:
	if !actions.has(action_name):
		return false
	return actions[action_name].is_active

func get_action_input_mode(action_name: String) -> InputMode.Type:
	if !actions.has(action_name): return InputMode.Type.None
	return actions[action_name].mode


func reset_all_actions() -> void:
	if actions.is_empty(): return
	for key in actions:
		actions[key].is_active = false

func _make_action(action_name: String, mode: InputMode.Type, active: bool = false) -> HoldToggleInputAction:
	return HoldToggleInputAction.new(action_name, mode, active)


func _process(delta: float) -> void:
	_check_actions()

func _check_actions() -> void:
	if actions.is_empty(): return
	for key in actions:
		actions[key].set_active_according_to_hold()
