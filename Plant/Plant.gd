extends Node2D

onready var growth_timer = $GrowthTimer
onready var rotting_timer = $RottingTimer
onready var picking_timer = $PickingTimer
onready var plant_sprite = $PlantSprite

var selected_plant
var is_rotted = false

var growth_percentage = 0
var growth_stage = 0;

const HERBOLOGY_BOOK = {
	'tomatoe': {'id': 0, 'has_fallback_state': true, 'grow_rate': 20, 'initial_happiness': 100, 'rotting_time': 10, 'picking_time': 4},
	'yellow_berry': {'id': 1, 'has_fallback_state': false, 'grow_rate': 10, 'initial_happiness': 100, 'rotting_time': 60, 'picking_time': 3},
	'blue_berry': {'id': 2, 'has_fallback_state': false, 'grow_rate': 10, 'initial_happiness': 100, 'rotting_time': 60, 'picking_time': 3},
	'lettuce': {'id': 3, 'has_fallback_state': false, 'grow_rate': 7, 'initial_happiness': 100, 'rotting_time': 100, 'picking_time': 3},
	'grey_goo': {'id': 4, 'has_fallback_state': false, 'grow_rate': 7, 'initial_happiness': 100, 'rotting_time': 600, 'picking_time': 3},
	'grape': {'id': 5, 'has_fallback_state': true, 'grow_rate': 5, 'initial_happiness': 100, 'rotting_time': 300, 'picking_time': 4},
	'garlic': {'id': 6, 'has_fallback_state': false, 'grow_rate': 7, 'initial_happiness': 100, 'rotting_time': 100, 'picking_time': 3},
	'blue_flower': {'id': 7, 'has_fallback_state': false, 'grow_rate': 15, 'initial_happiness': 100, 'rotting_time': 30, 'picking_time': 2},
	'red_flower': {'id': 8, 'has_fallback_state': false, 'grow_rate': 15, 'initial_happiness': 100, 'rotting_time': 30, 'picking_time': 2},
	'yellow_flower': {'id': 9, 'has_fallback_state': false, 'grow_rate': 15, 'initial_happiness': 100, 'rotting_time': 30, 'picking_time': 2},
	'pea': {'id': 10, 'has_fallback_state': true, 'grow_rate': 5, 'initial_happiness': 100, 'rotting_time': 300, 'picking_time': 4},
	'spinach': {'id': 11, 'has_fallback_state': false, 'grow_rate': 7, 'initial_happiness': 100, 'rotting_time': 100, 'picking_time': 3},
}

func _ready():
	set_plant('blue_berry')

func _process(delta):
	plant_sprite.frame_coords = Vector2(growth_stage, selected_plant['id'])
	
func set_plant(plant_name):
	selected_plant = HERBOLOGY_BOOK[plant_name]
	
	plant_sprite.frame_coords = Vector2(0, selected_plant['id'])
	rotting_timer.wait_time = selected_plant['rotting_time']
	picking_timer.wait_time = selected_plant['picking_time']

	growth_timer.start()

func _on_GrowthTimer_timeout():
	growth_percentage += selected_plant['grow_rate'];
	
	if growth_percentage >= 25:
		growth_percentage = 0
		
		if growth_stage < 4:
			growth_stage += 1
		elif !is_rotted && rotting_timer.time_left == 0:
			rotting_timer.start()
			

func _on_PickingTimer_timeout():
	if selected_plant['has_fallback_state'] && !is_rotted:
		growth_stage = 3
	else:
		queue_free()

func _on_RottingTimer_timeout():
	if growth_stage == 4:
		growth_stage = 5
		is_rotted = true
		rotting_timer.start()
	else:
		growth_stage = 6


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		print("clicked!")
