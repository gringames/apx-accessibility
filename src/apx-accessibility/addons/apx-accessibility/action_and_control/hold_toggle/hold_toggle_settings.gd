extends Control
class_name ActionHoldSettings

@export var input_action_names: Array[String] = []
@export var action_hold_entry_template: PackedScene
@onready var vbox: VBoxContainer = $VBoxContainer

func _ready() -> void:
	if input_action_names.is_empty(): return
	for action_name in input_action_names:
		var entry: ActionHoldEntry = action_hold_entry_template.instantiate()
		vbox.add_child(entry)
		entry.set_action_name(action_name)
		entry.set_hold_check_box(false) #TODO: fetch from IHTM
