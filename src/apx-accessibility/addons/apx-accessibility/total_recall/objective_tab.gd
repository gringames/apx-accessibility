extends HBoxContainer
class_name ObjectiveTab

@onready var objective_side_bar_buttons: SideBarButtons = $HBoxContainer/SideBarButtons
@onready var objective_content: ObjectiveContent = $"Contents"

var objective_display: ObjectiveDisplay

func _ready() -> void:
	objective_display = get_parent().get_parent() as ObjectiveDisplay
	if !objective_side_bar_buttons: return
	objective_side_bar_buttons.side_bar_button_pressed.connect(_on_side_bar_button_pressed)


func create_side_bar_buttons_for_objectives(objectives: Dictionary[String, Objective]) -> void:
	objective_side_bar_buttons.create_side_bar_buttons_for_objectives(objectives)
	objective_side_bar_buttons.set_objective_tab(self)

func _on_side_bar_button_pressed(key: String) -> void:
	_update_content(key)

func _update_content(key: String) -> void:
	if !objective_content: return
	var objective: Objective = objective_display.key_to_objective[key]
	if !objective: return
	objective_content.update_contents(objective.title, objective.description)
