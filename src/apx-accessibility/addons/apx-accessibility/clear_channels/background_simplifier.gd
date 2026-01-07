@tool
extends Node

@export var all_children_are_complex: bool = true
@export var complex_group_name: String = "ComplexBackgroundElement"

var children_with_tag: Array[Node]

func _ready() -> void:
	if all_children_are_complex:
		return
	for child in get_children():
		if child.is_in_group(complex_group_name):
			children_with_tag.append(child)

# TODO: later do this via event
func mock_complex_changed(new_hidden: bool) -> void:
	_on_hide_complex_changed(new_hidden)


func _on_hide_complex_changed(hidden: bool) -> void:
	var nodes_to_change: Array[Node] = _get_nodes_to_change()
	if nodes_to_change.is_empty():
		print("no complex background elements")
		return
	_change_visibility_of_group(nodes_to_change, hidden)


func _get_nodes_to_change() -> Array[Node]:
	if all_children_are_complex:
		return get_children()
	return children_with_tag

func _change_visibility_of_group(nodes: Array[Node], new_hidden: bool) -> void:
	if not nodes or nodes.is_empty():
		return
	for node: Node in nodes:
		if new_hidden:
			_hide_or_disable_node(node)
		else:
			_show_or_enable_node(node)
		

func _hide_or_disable_node(node: Node) -> void:
	if node.has_method("hide"):
		node.hide()
		return
	node.process_mode = Node.PROCESS_MODE_DISABLED # TODO: save current status


func _show_or_enable_node(node: Node) -> void:
	if node.has_method("show"):
		node.show()
		return
	node.process_mode = Node.PROCESS_MODE_INHERIT # TODO: reset current status
