@tool
extends EditorPlugin

const INPUT_MODE_NAME: String = "InputMode"
const INPUT_MODE_PATH: String = "res://addons/same_controls_but_different/hold_toggle/helpers/input_mode.gd"
const INPUT_HOLD_TOGGLE_MANAGER_NAME: String = "InputHoldToggleManager"
const INPUT_HOLD_TOGGLE_MANAGER_PATH: String = "res://addons/same_controls_but_different/hold_toggle/input_hold_toggle_manager.gd"


func _enter_tree() -> void:
	add_custom_type("InputHoldToggleManager", "Node", preload("hold_toggle/input_hold_toggle_manager.gd"), preload("icons/HoldToggleSettings.svg"))

func _exit_tree() -> void:
	remove_custom_type("InputHoldToggleManager")


func _enable_plugin() -> void:
	_add_autoloads()
	
func _disable_plugin() -> void:
	_remove_autoloads()


func _add_autoloads() -> void:
	_add_autoload(INPUT_MODE_NAME, INPUT_MODE_PATH)
	_add_autoload(INPUT_HOLD_TOGGLE_MANAGER_NAME, INPUT_HOLD_TOGGLE_MANAGER_PATH)

func _add_autoload(name: String, path: String) -> void:
	add_autoload_singleton(name, path)


func _remove_autoloads() -> void:
	remove_autoload_singleton(INPUT_MODE_NAME)
	remove_autoload_singleton(INPUT_HOLD_TOGGLE_MANAGER_NAME)
