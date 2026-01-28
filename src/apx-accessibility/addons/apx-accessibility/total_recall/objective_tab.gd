extends HBoxContainer
class_name ObjectiveTab

@onready var objective_side_bar_buttons: VBoxContainer = $"HBoxContainer/VBoxContainer TitlesForSelection"

func create_side_bar_buttons_for_objectives(objectives: Dictionary[String, Objective]) -> void:
	if !objectives or objectives.is_empty():
		push_warning("[Objective Tab] trying to creade sidebar buttons for empty objectives")
		# TODO: create empty view
		return
	for objective_key in objectives:
		var objective_title: String = objectives[objective_key].title
		var objective_button: ObjectiveButton = ObjectiveButton.new(objective_key, objective_title)
		objective_side_bar_buttons.add_child(objective_button)
