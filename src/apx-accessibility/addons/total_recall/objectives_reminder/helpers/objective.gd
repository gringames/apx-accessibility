extends Node
class_name Objective

var title: String
var description: String
var completed: bool
var image_path: String

func _init(title: String, description: String, completed: bool, image_path: String = "") -> void:
	self.title = title
	self.description = description
	self.completed = completed
	self.image_path = image_path


func _to_string() -> String:
	return "[" + title + ", " + description + "]" + " (" + ("done" if completed else "current") + ")"
