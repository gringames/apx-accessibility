extends Node

var custom_theme: Theme

signal text_theme_updated(Theme)

func notify_theme_update(new_theme: Theme) -> void:
	text_theme_updated.emit(new_theme)
