@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("ControlsReminder", "Sprite", preload("controls_reminder.gd"), preload("icons/ControlsReminder.svg"))


func _exit_tree():
	remove_custom_type("ControlsReminder")
