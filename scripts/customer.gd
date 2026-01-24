extends Node3D

## Vitesse de déplacement du client (en mètres par seconde)
@export var move_speed: float = 0.3

## Position de départ (début de la caisse, côté tapis)
@export var start_position: Vector3 = Vector3(-3.0, 0, 0.2)

## Position d'arrivée (fin de la caisse, côté panier)
@export var end_position: Vector3 = Vector3(1.5, 0, 0.2)

@onready var sprite: Sprite3D = $Sprite3D

var is_moving: bool = true

func _ready() -> void:
	position = start_position

func _process(delta: float) -> void:
	if not is_moving:
		return

	# Déplacer le client vers la position finale
	var direction = (end_position - position).normalized()
	position += direction * move_speed * delta

	# Vérifier si le client est arrivé
	if position.distance_to(end_position) < 0.1:
		is_moving = false
		_on_arrived()

func _on_arrived() -> void:
	print("Client arrivé à la caisse")
