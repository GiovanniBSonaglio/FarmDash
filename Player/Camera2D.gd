extends Camera2D

onready var map: Node2D = get_tree().get_root().get_node("World").get_node("Map")
onready var nav_2d: Navigation2D = map.get_node("Navigation2D")
onready var ground: TileMap = nav_2d.get_node("Ground")

func _ready():
	set_bounds(ground)

func calculate_bounds(tilemap):
	var cell_bounds = tilemap.get_used_rect()
	var cell_to_pixel = Transform2D(Vector2(tilemap.cell_size.x * tilemap.scale.x, 0), Vector2(0, tilemap.cell_size.y * tilemap.scale.y), Vector2())
	return Rect2(cell_to_pixel * cell_bounds.position, cell_to_pixel * cell_bounds.size)
	
func set_bounds(tilemap):
	var bounds = calculate_bounds(tilemap)
	limit_left = round(bounds.position.x) + 5
	limit_top = round(bounds.position.y)
	limit_right = round(bounds.size.x) - 45
	limit_bottom = round(bounds.size.y) - 45
