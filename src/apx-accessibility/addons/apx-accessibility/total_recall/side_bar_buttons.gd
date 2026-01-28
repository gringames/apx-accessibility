extends VBoxContainer
class_name SideBarButtons

signal side_bar_button_pressed(key: String)

var objective_tab: ObjectiveTab


func set_objective_tab(tab: ObjectiveTab) -> void:
	objective_tab = tab

func create_side_bar_buttons_for_objectives(objectives: Dictionary[String, Objective]) -> void:
	if !objectives or objectives.is_empty():
		push_warning("[Objective Tab] trying to creade sidebar buttons for empty objectives")
		# TODO: create empty view (or placeholders in scene)
		return
	for objective_key in objectives:
		var objective_title: String = objectives[objective_key].title
		var objective_button: ObjectiveButton = ObjectiveButton.new(objective_key, objective_title)
		add_child(objective_button)
	_display_first_objective(objectives)

func _display_first_objective(objectives: Dictionary[String, Objective]) -> void:
	notify_button_pressed(objectives.keys()[0])

func notify_button_pressed(key: String) -> void:
	side_bar_button_pressed.emit(key)
