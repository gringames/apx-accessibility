@tool
extends Node
class_name BackgroundSimplifier

@export var complex_group_names: Array[String] = ["ComplexBackgroundElement", "MovingBackgroundElement"]
@export var update_groups_during_runtime: bool = false
@export var hide_recursively: bool = false

const HIDE_METHOD: String = "hide"
const SHOW_METHOD: String = "show"

var complex_nodes: Array[Node]

func _ready() -> void:
	_update_complex_nodes()
	if complex_nodes.is_empty():
		print("no complex background elements found in scene!")


func _update_complex_nodes() -> void:
	complex_nodes.clear()
	if complex_group_names.is_empty(): return
	# using a dictionary ensures no duplicates if node is in two groups
	var complex_nodes_dict: Dictionary[Node, bool] = {}
	for group_name in complex_group_names:
		for node in get_tree().get_nodes_in_group(group_name):
			complex_nodes_dict[node] = true
	complex_nodes = complex_nodes_dict.keys()
	complex_nodes_dict.clear()


func _on_reduce_complexity_changed(new_reduce_complexity: bool) -> void:
	# search for nodes each update if requested
	if update_groups_during_runtime:
		_update_complex_nodes()
	if complex_nodes.is_empty(): return
	_change_visibility_of_group(complex_nodes, new_reduce_complexity)


func _change_visibility_of_group(nodes: Array[Node], new_hidden: bool) -> void:
	if not nodes or nodes.is_empty(): return
	for node: Node in nodes:
		_set_node_visibility(node, new_hidden)


func _set_node_visibility(node: Node, new_hidden: bool) -> void:
	var visibility_method_name: String = HIDE_METHOD if new_hidden else SHOW_METHOD 
	if !hide_recursively and node.has_method(visibility_method_name):
		node.call(visibility_method_name)
	else:
		node.propagate_call(visibility_method_name)
