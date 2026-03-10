@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("InputHoldToggleManager", "Node", preload("hold_toggle/input_hold_toggle_manager.gd"), preload("icons/HoldToggleSettings.svg"))

func _exit_tree() -> void:
	remove_custom_type("InputHoldToggleManager")
