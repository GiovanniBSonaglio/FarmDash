extends Node

onready var nav_2d: Navigation2D = get_tree().get_root().get_node("World").get_node("Map").get_node("Navigation2D")
onready var line_2d: Line2D = $Line2D
onready var character: Sprite = $Character

func _unhandled_input(event):
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	
	var new_path = nav_2d.get_simple_path(Vector2(character.global_position), Vector2(event.global_position), false)
	
	line_2d.points = new_path
	character.path = new_path
