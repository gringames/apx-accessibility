@tool
extends Node
class_name BackgroundSimplifier

@export var complex_group_names: Array[String] = ["ComplexBackgroundElement", "MovingBackgroundElement"]
@export var update_group_during_runtime: bool = false

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
	if update_group_during_runtime:
		_update_complex_nodes()
	if complex_nodes.is_empty():
		return
	_change_visibility_of_group(complex_nodes, new_reduce_complexity)


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
