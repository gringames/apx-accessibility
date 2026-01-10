extends Node

var custom_theme: Theme

signal text_theme_updated

func notify_theme_update() -> void:
	text_theme_updated.emit()
