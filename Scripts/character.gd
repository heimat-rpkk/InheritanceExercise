class_name Character
extends CharacterBody2D

@export var speed : float = 200.0
@export var gravity : float = 900.0
@export var health : int = 3
@export var is_player : bool = false
var can_take_damage := true


func _physics_process(delta: float)-> void:
	handle_movement(delta)
	apply_gravity(delta)
	check_collisions()
	move_and_slide()


func handle_movement(_delta: float) -> void:
	pass


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta


func take_damage(amount: int):
	if not can_take_damage:
		return # Poistuttaan funktiosta, jos ollaan haavoittumattomia

	health -= amount
	print(name + " health: ", health)

	if health <= 0:
		die()
	else:
		start_invincibility()

func start_invincibility():
	can_take_damage = false
	# Luodaan ajastin koodilla
	await get_tree().create_timer(1.5).timeout 
	can_take_damage = true


func die()-> void:
	print(name + " died")
	queue_free()


func check_collisions() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is Character:
			# Pelaaja hyppää vihollisen päälle
			if is_player and collision.get_normal().y < -0.7:
				collider.take_damage(1)
				velocity.y = -300

			# Tavallinen törmäys
			else:
				collider.take_damage(1)
			
			
