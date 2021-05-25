extends Sprite

onready var animation: AnimationPlayer = $AnimationPlayer

var speed : = 150.0
var path : = PoolVector2Array() setget set_path
var direction = ''

func _ready():
	
	set_process(false)
	
func _process(delta: float):
	var move_distance : = speed * delta
	move_along_path(move_distance)
	animate_movement()
	
func move_along_path(distance: float):
	var start_point: = position

	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			direction = path[0]
			
			if path[0].x > position.x:
				direction = 'right'
			if path[0].x < position.x:
				direction = 'left'
			if path[0].y < position.y:
				direction = 'up'
			if path[0].y > position.y:
				direction = 'down'
				
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			break
		distance = distance - distance_to_next
		start_point = path[0]
		path.remove(0)
	
func set_path(value: PoolVector2Array):
	path = value
	if value.size() == 0:
		return
	set_process(true)

func animate_movement():
	if direction == 'right':
		animation.play("moveRIGHT")
	if direction == 'left':
		animation.play("moveLEFT")
	if direction == 'up':
		animation.play("moveUP")
	if direction == 'down':
		animation.play("moveDOWN")
