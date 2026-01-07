@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("BackgroundSimplifier", "Node", preload("background_simplifier.gd"), preload("res://icon.svg"))


func _exit_tree() -> void:
	remove_custom_type("BackgroundSimplifier")
