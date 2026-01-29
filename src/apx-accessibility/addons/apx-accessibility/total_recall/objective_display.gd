@icon("icons/ObjectiveDisplay.svg")
extends Control
class_name ObjectiveDisplay

@onready var current_objective_tab: ObjectiveTab = $TabContainer/Current
@onready var completed_objective_tab: ObjectiveTab = $TabContainer/Completed

var key_to_objective: Dictionary[String, Objective] = {}

func _ready() -> void:
	_create_example_objectives()
	current_objective_tab.create_side_bar_buttons_for_objectives(get_current_objectives())
	completed_objective_tab.create_side_bar_buttons_for_objectives(get_completed_objectives())


func make_objective(title: String, description: String, completed: bool, image_path: String = "") -> Objective:
	return Objective.new(title, description, completed, image_path)

func add_objective(key: String, objective: Objective) -> void:
	if key_to_objective.has(key):
		push_warning("trying to add objective with existing key (", key,  "), use update_objective instead.")
		return
	key_to_objective[key] = objective
	_append_objective(key, objective)

func remove_objective(key: String) -> void:
	var objective = key_to_objective[key]
	if !objective: 
		push_warning("trying to remove non-existent objective, (key: ", key, ")")
		return
	_remove_objective_from_tab(key)
	key_to_objective.erase(key)

func update_objective(key: String, updated_objective: Objective) -> void:
	var objective = key_to_objective[key]
	if !objective: 
		push_warning("trying to update non-existent objective, (key: ", key, "). Adding it instead")
		add_objective(key, updated_objective)
		return
	if not objective.completed and updated_objective.completed:
		complete_objective(key)
	key_to_objective[key] = updated_objective


func complete_objective(key: String) -> void:
	var objective = key_to_objective[key]
	if !objective: 
		push_warning("trying to complete non-existent objective, (key: ", key, ")")
		return
	objective.completed = true
	current_objective_tab.remove_objective(key)
	completed_objective_tab.add_objective(key, objective)


func _append_objective(key: String, objective: Objective) -> void:
	var tab: ObjectiveTab = completed_objective_tab if objective.completed else current_objective_tab
	tab.add_objective(key, objective)

func _remove_objective_from_tab(key: String) -> void:
	_get_tab(key).remove_objective(key)

func _get_tab(key) -> ObjectiveTab:
	var objective: Objective = key_to_objective[key]
	if !objective: return null
	return completed_objective_tab if objective.completed else current_objective_tab
	

func get_completed_objectives() -> Dictionary[String, Objective]:
	return _filter_dict_by_completion(true)

func get_current_objectives() -> Dictionary[String, Objective]:
	return _filter_dict_by_completion(false)

func _filter_dict_by_completion(completed: bool) -> Dictionary[String, Objective]:
	var dict: Dictionary[String, Objective] = {}
	if key_to_objective.is_empty(): return dict
	for key in key_to_objective:
		if key_to_objective[key].completed == completed:
			dict[key] = key_to_objective[key]
	return dict

# for testing ----------------------------------------------------------------------

func print_objectives(grouped: bool) -> void:
	if !grouped:
		print(JSON.stringify(key_to_objective, "\t"))
	else:
		print("completed: ", JSON.stringify(get_completed_objectives(), "\t"))
		print("current: ", JSON.stringify(get_current_objectives(), "\t"))

func _create_example_objectives() -> void:
	_add_objective_to_dict("talo", make_objective("Talo's Tale", "Fight the boss Talo and redeem your reward!", false))
	_add_objective_to_dict("100steps", make_objective("You Can Move!", "Walk 100 steps in total.", false))
	_add_objective_to_dict("5seeds", make_objective("Seedy Situation", "Find 5 seeds and bring them to X!", true))
	_add_objective_to_dict("first_seed", make_objective("Take a Seed", "Find your first seed!", true))
	_add_objective_to_dict("first_gold", make_objective("It's Gold!", "Find your first gold!", true))
	_add_objective_to_dict("first_task", make_objective("You're Welcome!", "Complete your first NPC quest!", true))
	_add_objective_to_dict("first_steps", make_objective("Your First Steps", "Move by using the arrow keys.", true))
	_add_objective_to_dict("1000steps", make_objective("Runner!", "Walk 1000 steps in total.", true))
	_add_objective_to_dict("10000steps", make_objective("Marathon Runner!", "Walk 10000 steps in total.", true))
	_add_objective_to_dict("100000steps", make_objective("Around the World!", "Walk 100000 steps in total.", true))
	_add_objective_to_dict("first_death", make_objective("Game Over!", "Die for the first time.", true))


func _add_objective_to_dict(key: String, objective: Objective) -> void:
	key_to_objective[key] = objective
