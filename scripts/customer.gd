extends Node3D

## Vitesse de déplacement du client (en mètres par seconde)
@export var move_speed: float = 0.1

## Position de départ (début de la caisse, côté tapis)
@export var start_position: Vector3 = Vector3(-3.0, 0, 0.2)

## Position d'arrivée (fin de la caisse, côté panier)
@export var end_position: Vector3 = Vector3(1.5, 0, 0.2)

## Paramètres du balancier de marche
@export var bob_frequency: float = 0.8  # Fréquence du rebond vertical (Hz)
@export var bob_amplitude: float = 0.01  # Amplitude du rebond vertical (mètres)
@export var sway_frequency: float = 0.6  # Fréquence du balancement latéral (Hz)
@export var sway_amplitude: float = 0.02  # Amplitude du balancement (radians)

@onready var sprite: Sprite3D = $Sprite3D

var is_moving: bool = true
var walk_time: float = 0.0
var base_sprite_y: float = 0.0

func _ready() -> void:
	position = start_position
	base_sprite_y = sprite.position.y

func _process(delta: float) -> void:
	if not is_moving:
		return

	walk_time += delta

	# Déplacer le client vers la position finale
	var direction = (end_position - position).normalized()
	position += direction * move_speed * delta

	# Effet de balancier vertical (rebond de marche)
	var bob_offset = abs(sin(walk_time * bob_frequency * TAU)) * bob_amplitude
	sprite.position.y = base_sprite_y + bob_offset

	# Effet de balancement latéral (tangage)
	sprite.rotation.z = sin(walk_time * sway_frequency * TAU) * sway_amplitude

	# Vérifier si le client est arrivé
	if position.distance_to(end_position) < 0.1:
		is_moving = false
		_on_arrived()

func _on_arrived() -> void:
	# Remettre le sprite en position neutre
	sprite.position.y = base_sprite_y
	sprite.rotation.z = 0.0
	print("Client arrivé à la caisse")
