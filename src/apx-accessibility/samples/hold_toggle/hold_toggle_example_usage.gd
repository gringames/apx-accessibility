extends Node

const PRINT_HELLO_ACTION_NAME: String = "print_hello"
const PRINT_BYE_ACTION_NAME: String = "print_bye_bye"

func _ready() -> void:
	InputHoldToggleManager.add_action(PRINT_HELLO_ACTION_NAME)
	InputHoldToggleManager.add_action(PRINT_BYE_ACTION_NAME, InputMode.Type.Toggle)

func _process(_delta: float) -> void:
	if InputHoldToggleManager.is_action_active(PRINT_HELLO_ACTION_NAME):
		print("hello")
	if InputHoldToggleManager.is_action_active(PRINT_BYE_ACTION_NAME):
		print("bye bye")
