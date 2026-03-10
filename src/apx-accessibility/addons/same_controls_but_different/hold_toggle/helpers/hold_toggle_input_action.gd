extends Node
class_name HoldToggleInputAction

var action_name: String = ""
var mode: InputMode.Type = InputMode.Type.Toggle
var is_active: bool = false

func _init(action_name: String, mode: InputMode.Type, active: bool = false) -> void:
	self.action_name = action_name
	self.mode = mode
	is_active = active


func reset() -> void:
	is_active = false 

func set_active_according_to_hold() -> void:
	if mode == InputMode.Type.Hold:
		is_active = Input.is_action_pressed(action_name)
	else:
		if Input.is_action_just_pressed(action_name):
			is_active = !is_active
