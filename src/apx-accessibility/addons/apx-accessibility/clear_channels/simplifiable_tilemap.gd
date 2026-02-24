extends TileMapLayer
class_name SimplifiableTilemap

func _on_hide_complex_changed(hide_complex: bool) -> void:
# gets the atlas coords for the cell in the tilemap layer in the level
	get_cell_atlas_coords(Vector2i(0,0))
