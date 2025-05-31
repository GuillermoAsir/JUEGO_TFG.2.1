extends TileMapLayer

@export var view_distance: int = 20
@export var player: Node2D
#@export var tile_set: TileSet

func _process(delta):
	update_visible_tiles()

func update_visible_tiles():
	if tile_set == null:
		print("TileSet no asignado")
		return

	var tile_size = tile_set.tile_size
	var player_pos = local_to_map(to_local(player.global_position))

	var min_x = player_pos.x - view_distance
	var max_x = player_pos.x + view_distance
	var min_y = player_pos.y - view_distance
	var max_y = player_pos.y + view_distance

	# Obtener área usada del mapa
	var used_rect = get_used_rect()
	for x in range(used_rect.position.x, used_rect.end.x):
		for y in range(used_rect.position.y, used_rect.end.y):
			if x < min_x or x > max_x or y < min_y or y > max_y:
				set_cell(Vector2i(x, y), -1, Vector2i.ZERO)  # Borrar tile
			else:
				var tile_id = get_cell_source_id(Vector2i(x, y))
				if tile_id >= 0:
					set_cell(Vector2i(x, y), tile_id, Vector2i.ZERO)
