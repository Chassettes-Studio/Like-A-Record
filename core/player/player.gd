class_name Player
extends CharacterBody2D

signal died

@export var DASH_SPEED: float = 5_000
@export var DASH_ACCELERATION: float = 50_000

var current_state: State = MovingState.new(self)

@onready var hitbox: Hitbox = $Hitbox

@onready var health_controller: SCHealthController = $SCHealthController
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer

@onready var sc_physics_controller: SCPhysicsController = $SCPhysicsController
@onready var dash_cooldown: Timer = $DashCooldown
@onready var gun: Gun = $Gun


func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)
	if Input.is_action_just_pressed("ui_accept"):
		gun.shoot(Vector2.RIGHT.rotated(gun.rotation))


func update_current_state(state: State) -> void:
	self.current_state.on_exit()
	self.current_state = state
	self.current_state.on_enter()


func _on_hitbox_hurt(_value: float) -> void:
	health_controller.take_damage(1)
	hitbox.set_hittable(false)
	invulnerability_timer.start()


func _on_invulnerability_timer_timeout() -> void:
	hitbox.set_hittable(true)


func _on_sc_health_controller_died() -> void:
	died.emit()
	queue_free()
