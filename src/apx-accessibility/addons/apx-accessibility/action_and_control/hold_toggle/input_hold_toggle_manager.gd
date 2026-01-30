extends Node

enum InputMode {Hold, Toggle}

var actions: Dictionary[String, HoldToggleInputAction] = {}

func _ready() -> void:
	add_action("print_hello", make_action("print_hello", InputMode.Toggle))
	if actions and actions.is_empty():
		set_process(false)

func is_action_active(action_name: String) -> bool:
	if !actions.has(action_name):
		return false
	return actions[action_name].is_active


func add_action(action_name: String, action: HoldToggleInputAction) -> void:
	if !actions.has(action_name):
		actions[action_name] = action
	if actions.size() == 1:
		set_process(true)

func remove_action(action_name: String) -> void:
	if actions.has(action_name):
		actions.erase(action_name)
	if actions.is_empty():
		set_process(false)

func update_action(action_name: String, hold: bool) -> void:
	if actions.has(action_name):
		actions[action_name].has_to_be_held = hold

func reset_all_actions() -> void:
	if actions.is_empty(): return
	for key in actions:
		actions[key].is_active = false

func make_action(action_name: String, mode: InputMode, active: bool = false) -> HoldToggleInputAction:
	return HoldToggleInputAction.new(action_name, mode, active)


func _process(delta: float) -> void:
	_check_actions()

func _check_actions() -> void:
	if actions.is_empty(): return
	for key in actions:
		actions[key].set_active_according_to_hold()
