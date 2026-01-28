extends Button
class_name ObjectiveButton

var title: String
var key: String

func _init(key: String, title: String) -> void:
	set_title_and_key(title, key)
	alignment = HORIZONTAL_ALIGNMENT_LEFT

func set_title_and_key(title: String, key: String) -> void:
	set_title(title)
	set_key(key)

func set_title(title: String) -> void:
	self.title = title
	text = title

func set_key(key: String) -> void:
	self.key = key
