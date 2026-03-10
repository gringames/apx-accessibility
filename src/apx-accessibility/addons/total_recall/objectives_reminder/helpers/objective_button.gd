extends Button
class_name ObjectiveButton

var title: String
var key: String

var side_bar: SideBarButtons

func _ready() -> void:
	side_bar = get_parent() as SideBarButtons
	pressed.connect(_on_pressed)

func _init(key: String, title: String) -> void:
	set_title_and_key(title, key)
	alignment = HORIZONTAL_ALIGNMENT_LEFT
	autowrap_mode = TextServer.AUTOWRAP_WORD

func set_title_and_key(title: String, key: String) -> void:
	set_title(title)
	set_key(key)

func set_title(title: String) -> void:
	self.title = title
	text = title

func set_key(key: String) -> void:
	self.key = key

func _on_pressed() -> void:
	if !side_bar: return
	side_bar.notify_button_pressed(key)
