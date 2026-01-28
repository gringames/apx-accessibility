extends VBoxContainer
class_name SideBarButtons

signal side_bar_button_pressed(key: String)

var objective_tab: ObjectiveTab
var buttons: Dictionary[String, Button] = {}

func set_objective_tab(tab: ObjectiveTab) -> void:
	objective_tab = tab

func create_side_bar_buttons_for_objectives(objectives: Dictionary[String, Objective]) -> void:
	if !objectives or objectives.is_empty():
		push_warning("[Objective Tab] trying to creade sidebar buttons for empty objectives")
		# TODO: create empty view (or placeholders in scene)
		return
	_remove_all_button_children()
	for objective_key in objectives:
		append_objective(objective_key, objectives[objective_key])
	_display_first_objective(objectives)

func append_objective(objective_key: String, objective: Objective) -> void:
	if buttons.has(objective_key): return
	var objective_title: String = objective.title
	var objective_button: ObjectiveButton = ObjectiveButton.new(objective_key, objective_title)
	objective_button.autowrap_mode = TextServer.AUTOWRAP_WORD
	add_child(objective_button)
	buttons[objective_key] = objective_button

func remove_objective(objective_key: String) -> void:
	if !buttons.has(objective_key): return
	var button: Button = buttons[objective_key]
	buttons.erase(objective_key)
	remove_child(button)

func _remove_all_button_children() -> void:
	for child in get_children():
		if child is Button:
			child.queue_free()
	buttons.clear()


func _display_first_objective(objectives: Dictionary[String, Objective]) -> void:
	notify_button_pressed(objectives.keys()[0])

func notify_button_pressed(key: String) -> void:
	side_bar_button_pressed.emit(key)
