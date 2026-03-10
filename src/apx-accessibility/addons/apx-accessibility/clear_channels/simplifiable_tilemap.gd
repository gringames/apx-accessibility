@tool
extends TileMapLayer
class_name SimplifiableTilemapLayer

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		_setup()

func _setup() -> void:
	print("setting up")
	if not tile_set:
		tile_set = TileSet.new()
	_add_custom_data_layer("complex", TYPE_BOOL)
	_add_custom_data_layer("alternative_coords", TYPE_VECTOR2I)

func _add_custom_data_layer(layer_name: String, type: Variant.Type) -> void:
	if tile_set.has_custom_data_layer_by_name(layer_name):
		push_warning("[SimplifiableTileMapLayer] ", name, " already has custom data layer ", layer_name)
		return
	var data_position: int = tile_set.get_custom_data_layers_count()
	tile_set.add_custom_data_layer()
	tile_set.set_custom_data_layer_name(data_position, layer_name)
	tile_set.set_custom_data_layer_type(data_position, type)

func _on_hide_complex_changed(hide_complex: bool) -> void:
	pass
