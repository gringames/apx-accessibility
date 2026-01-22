extends Button
class_name ObjectiveButton

var title: String
var key: String

func set_title(title) -> void:
	self.title = title
	text = title
