extends Node

onready var map: Node2D = get_tree().get_root().get_node("World").get_node("Map")
onready var nav_2d: Navigation2D = map.get_node("Navigation2D")
onready var spawn: Position2D = map.get_node("SpawnPoint")
onready var line_2d: Line2D = $Line2D
onready var character: Sprite = $Character
onready var camera: Camera2D = character.get_node("Camera2D")

func _ready():
	character.global_position = spawn.position

func _unhandled_input(event):
		
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	var new_path = nav_2d.get_simple_path(character.global_position, camera.get_global_mouse_position(), false)
	
	line_2d.points = new_path
	character.path = new_path
