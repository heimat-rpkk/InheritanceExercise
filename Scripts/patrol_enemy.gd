class_name PatrolEnemy 
extends Character

@export var patrol_distance : float = 100.0
var start_position : Vector2
var direction : int = -1

func _ready() -> void:
	start_position = global_position


# Ylikirjoitus
func handle_movement(_delta) -> void:
	velocity.x = direction * speed
	$Sprite2D.flip_h = direction == 1
	
	if global_position.x > start_position.x + patrol_distance:
			direction = -1

	elif global_position.x < start_position.x - patrol_distance:
		direction = 1
	else:
		# Säilytetään nykyinen suunta
		pass
	
