class_name Player
extends Character

@export var jump_velocity : float = -400.0
var is_invisible := false


# Ylikirjoitus
func handle_movement(_delta) -> void:
	# Input
	var direction = 0

	if Input.is_action_pressed("ui_left"):
		direction -= 1
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("ui_right"):
		direction += 1
		$Sprite2D.flip_h = false

	velocity.x = direction * speed

	# Jump
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = jump_velocity


# Tämä funktio ajetaan aina, kun moottori havaitsee minkä tahansa syötteen 
# (hiiren liike, näppäimistö, ohjain). Parametri 'event' sisältää tiedon siitä, mitä tapahtui.
func _input(event: InputEvent) -> void: 

	# Tarkistetaan, onko tapahtuma (event) nimenomaan "invisible"-toiminnon painallus.
	# "invisible" pitää määritellä Input Mapissä
	# .is_action_pressed() palauttaa 'true' vain, kun näppäin painetaan alas.
	if event.is_action_pressed("invisible"):
		
		# Jos ehto täyttyy, kutsutaan omaa funktiota, joka vaihtaa näkyvyystilaa.
		toggle_invisibility()

func toggle_invisibility():
	is_invisible = !is_invisible # Vaihtaa true -> false tai false -> true
	# Poistetaan törmäyskerros ja -maski
	# collision_layer 1 on oletus. Asetetaan se nollaksi (ei kerrosta) 
	# tai takaisin ykköseksi.
	set_collision_layer_value(2, !is_invisible)
	set_collision_mask_value(2, !is_invisible)
	# yhden rivin if-else-lause
	modulate.a = 0.3 if is_invisible else 1.0
