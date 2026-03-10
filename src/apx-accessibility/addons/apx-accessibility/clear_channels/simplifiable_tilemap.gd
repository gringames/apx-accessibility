@tool
extends TileMapLayer
class_name SimplifiableTilemapLayer

const CUSTOM_DATA_COMPLEX: String = "complex"
const CUSTOM_DATA_ORIGINAL_COORDS: String = "original_coords"
const CUSTOM_DATA_ALT_COORDS: String = "alternative_coords"

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		_setup()

func _setup() -> void:
	if not tile_set:
		tile_set = TileSet.new()
	_add_custom_data_layer(CUSTOM_DATA_COMPLEX, TYPE_BOOL)
	_add_custom_data_layer(CUSTOM_DATA_ORIGINAL_COORDS, TYPE_VECTOR2I)
	_add_custom_data_layer(CUSTOM_DATA_ALT_COORDS, TYPE_VECTOR2I)

func _add_custom_data_layer(layer_name: String, type: Variant.Type) -> void:
	if tile_set.has_custom_data_layer_by_name(layer_name):
		push_warning("[SimplifiableTileMapLayer] ", name, " already has custom data layer ", layer_name)
		return
	var data_position: int = tile_set.get_custom_data_layers_count()
	tile_set.add_custom_data_layer()
	tile_set.set_custom_data_layer_name(data_position, layer_name)
	tile_set.set_custom_data_layer_type(data_position, type)




func _ready() -> void:
	_on_hide_complex_changed(true)

func _on_hide_complex_changed(hide_complex: bool) -> void:
	for coords in get_used_cells():
		var tile_data: TileData = get_cell_tile_data(coords)
		if _tile_is_complex(tile_data):
			_swap_complex_tile(coords, tile_data, hide_complex)

func _tile_is_complex(tile_data: TileData) -> bool:
	if not tile_data:
		return false
	return tile_data.get_custom_data(CUSTOM_DATA_COMPLEX)


func  _swap_complex_tile(coords: Vector2i, tile_data: TileData, hide_complex: bool) -> void:
	var alternative_coords: Vector2i = tile_data.get_custom_data(CUSTOM_DATA_ALT_COORDS)
	set_cell(coords, get_cell_source_id(coords), alternative_coords)
