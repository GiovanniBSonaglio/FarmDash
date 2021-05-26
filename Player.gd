extends Node

onready var nav_2d: Navigation2D = get_tree().get_root().get_node("World").get_node("Map").get_node("Navigation2D")
onready var spawn: Position2D = get_tree().get_root().get_node("World").get_node("Map").get_node("SpawnPoint")
onready var line_2d: Line2D = $Line2D
onready var character: Sprite = $Character

func _ready():
	character.global_position = spawn.position

func _unhandled_input(event):
	
	print(get_viewport().get_mouse_position())
	
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	var new_path = nav_2d.get_simple_path(Vector2(character.global_position), Vector2(get_viewport().get_mouse_position()), false)
	
	line_2d.points = new_path
	character.path = new_path
