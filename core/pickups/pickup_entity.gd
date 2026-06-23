class_name PickupEntity
extends Node2D

var attraction: float = 100000000000

var slow_down: float = 100000000

var velocity: Vector2

var target: Player

@onready var texture_rect: TextureRect = $TextureRect

@export var pickup: Pickup

func _ready() -> void:
	texture_rect.texture = pickup.texture


func _physics_process(delta: float) -> void:
	_update_velocity(delta)
	global_position += velocity * delta


func _update_velocity(delta: float) -> void:
	if not target:
		velocity.move_toward(Vector2.ZERO, slow_down * delta)
		return

	var acceleration := (1 / global_position.distance_to(target.global_position) ** 4) * attraction
	velocity += acceleration * delta * global_position.direction_to(target.global_position)


func _on_follow_area_body_entered(body: Node2D) -> void:
	var player := body as Player
	if player:
		target = body


func _on_follow_area_body_exited(body: Node2D) -> void:
	if body == target:
		target = null

func _on_pickup_area_body_entered(body: Node2D) -> void:
	var player := body as Player
	if player:
		for effect in pickup.effects:
			effect.apply(player)
		queue_free()
