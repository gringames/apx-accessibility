@icon("icons/ObjectiveDisplay.svg")
extends Control
class_name ObjectiveDisplay

@onready var current_objective_tab: ObjectiveTab = $TabContainer/Current
@onready var completed_objective_tab: ObjectiveTab = $TabContainer/Completed

var key_to_objective: Dictionary[String, Objective] = {}

func _ready() -> void:
	add_example_objectives()
	# print_objectives(true)
	current_objective_tab.create_side_bar_buttons_for_objectives(get_current_objectives())
	completed_objective_tab.create_side_bar_buttons_for_objectives(get_completed_objectives())

func add_objective(key: String, objective: Objective) -> void:
	key_to_objective[key] = objective


func make_objective(title: String, description: String, completed: bool, image_path: String = "") -> Objective:
	return Objective.new(title, description, completed, image_path)


func get_completed_objectives() -> Dictionary[String, Objective]:
	return filter_dict_by_completion(true)

func get_current_objectives() -> Dictionary[String, Objective]:
	return filter_dict_by_completion(false)

func filter_dict_by_completion(completed: bool) -> Dictionary[String, Objective]:
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

func add_example_objectives() -> void:
	add_objective("test", make_objective("title", "description", false))
	add_objective("talo", make_objective("Talo's Tale", "Fight the boss Talo and redeem your reward!", false))
	add_objective("5seeds", make_objective("Seedy Situation", "Find 5 seeds and bring them to X!", false))
	add_objective("first_seed", make_objective("Take a Seed", "Find your first seed!", true))
	add_objective("first_gold", make_objective("It's Gold!", "Find your first gold!", true))
	add_objective("first_task", make_objective("You're Welcome!", "Complete your first NPC quest!", true))
	add_objective("first_steps", make_objective("Your First Steps", "Move by using the arrow keys.", true))
	add_objective("100steps", make_objective("You Can Move!", "Walk 100 steps in total.", true))
	add_objective("1000steps", make_objective("Runner!", "Walk 1000 steps in total.", true))
	add_objective("10000steps", make_objective("Marathon Runner!", "Walk 10000 steps in total.", true))
	add_objective("100000steps", make_objective("Around the World!", "Walk 100000 steps in total.", true))
	add_objective("first_death", make_objective("Game Over!", "Die for the first time.", true))
