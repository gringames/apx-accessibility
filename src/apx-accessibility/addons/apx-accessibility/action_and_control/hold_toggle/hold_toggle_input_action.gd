extends Node
class_name HoldToggleInputAction

var action_name: String = ""
var mode: InputHoldToggleManager.InputMode = InputHoldToggleManager.InputMode.Toggle
var is_active: bool = false

func _init(action_name: String, mode: InputHoldToggleManager.InputMode, active: bool = false) -> void:
	self.action_name = action_name
	self.mode = mode
	is_active = active


func reset() -> void:
	is_active = false 

func set_active_according_to_hold() -> void:
	if mode == InputHoldToggleManager.InputMode.Hold:
		is_active = Input.is_action_pressed(action_name)
	else:
		if Input.is_action_just_pressed(action_name):
			is_active = !is_active
