extends Node

signal visibility_reduction_toggled(toggled_on: bool)

func toggle_visibility_reduction(enabled: bool) -> void:
	visibility_reduction_toggled.emit(enabled)
	# uncomment this for testing:
	# print("visibility reduction: ", enabled)
