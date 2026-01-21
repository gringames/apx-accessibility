extends Node
class_name Objective

var title: String
var description: String
var completed: bool
var image: Texture2D

func _init(title: String, description: String, completed: bool, image: Texture2D) -> void:
	self.title = title
	self.description = description
	self.completed = completed
	self.image = image


func _to_string() -> String:
	return "[" + title + ", " + description + "]" + " (" + ("done" if completed else "current") + ")"
