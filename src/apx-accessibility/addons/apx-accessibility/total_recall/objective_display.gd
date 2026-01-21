@icon("icons/ObjectiveDisplay.svg")
extends Control
class_name ObjectiveDisplay

var key_to_objective: Dictionary[String, Objective] = {}

func _ready() -> void:
	add_objective("test", make_objective("title", "description", true, null))
	add_objective("talo", make_objective("Talo's Tale", "Fight the boss Talo and redeem your reward!", false, null))
	print_objectives()

func add_objective(key: String, objective: Objective) -> void:
	key_to_objective[key] = objective


func make_objective(title: String, description: String, completed: bool, image: Texture2D) -> Objective:
	return Objective.new(title, description, completed, image)


func print_objectives() -> void:
	print(JSON.stringify(key_to_objective, "\t"))
