extends HBoxContainer
class_name ActionHoldEntry

@onready var action_name_label: Label = $ActionName
@onready var hold_check_button: CheckButton = $HoldCheckButton

func set_action_name(action_name: String) -> void:
	action_name_label.text = action_name

func set_hold_check_box(checked: bool) -> void:
	hold_check_button.button_pressed = checked
