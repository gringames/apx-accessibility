@tool
extends Node

@export var complex_group_name: String = "ComplexBackgroundElement"
@export var update_group_during_runtime: bool = false

var complex_nodes: Array[Node]

func _ready() -> void:
	_update_complex_nodes()
	if complex_nodes.is_empty():
		print("no complex background elements found in scene!")


func _update_complex_nodes() -> void:
	complex_nodes = get_tree().get_nodes_in_group(complex_group_name)


# TODO: later do this via event
func mock_complex_changed(new_hidden: bool) -> void:
	_on_hide_complex_changed(new_hidden)


func _on_hide_complex_changed(hidden: bool) -> void:
	# search for nodes each update if requested
	if update_group_during_runtime:
		_update_complex_nodes()
	if complex_nodes.is_empty():
		return
	_change_visibility_of_group(complex_nodes, hidden)


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


func _show_or_enable_node(node: Node) -> void:
	if node.has_method("show"):
		node.show()
