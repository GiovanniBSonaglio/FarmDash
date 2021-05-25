extends Node

onready var nav_2d: Navigation2D = $Navigation2D#get_node("/root/Map/Map/Navigation2D")
onready var line_2d: Line2D = $Line2D
onready var character: Sprite = $Character
onready var animation: AnimationPlayer = $AnimationPlayer

func _unhandled_input(event):
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	
	var new_path = nav_2d.get_simple_path(Vector2(character.global_position), Vector2(event.global_position), false)
	if event.global_position.x > character.global_position.x:
		print("Right")
		animation.play("moveRIGHT")
	if event.global_position.x < character.global_position.x:
		print("Left")
		animation.play("moveLEFT")
	if event.global_position.y < character.global_position.y:
		print("Up")
		animation.play("moveUP")
	if event.global_position.y > character.global_position.y:
		print("Down")
		animation.play("moveDOWN")			
	line_2d.points = new_path
	character.path = new_path
