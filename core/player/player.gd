class_name Player
extends CharacterBody2D

signal died
signal damaged

@export var DASH_SPEED: float = 5_000
@export var DASH_ACCELERATION: float = 50_000

@export var upgrades: Array[Upgrade] = []

var current_state: State = MovingState.new(self, Vector2.RIGHT)

@onready var blink_timer: Timer = $BlinkTimer
var deathScreen: PackedScene = preload("res://core/ui/death/DeathScreen.tscn")

@onready var hitbox: Hitbox = $Hitbox

@onready var health_controller: SCHealthController = $SCHealthController
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer

@onready var sc_physics_controller: SCPhysicsController = $SCPhysicsController
@onready var dash_cooldown: Timer = $DashCooldown
@onready var gun: Gun = $Gun
@onready var ui: PlayerUi = $PlayerUi

@export var character : Character


func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)
	if Input.is_action_just_pressed("ui_accept"):
		gun.shoot(Vector2.RIGHT.rotated(gun.rotation))


func update_current_state(state: State) -> void:
	self.current_state.on_exit()
	self.current_state = state
	self.current_state.on_enter()


func apply_upgrade(upgrade: Upgrade) -> void:
	upgrades.push_front(upgrade)
	for p_effect in upgrade.player_effects:
		p_effect.apply(self)
	for g_effect in upgrade.gun_effects:
		g_effect.apply(self.gun)
	gun.bullet.bullet_effects.append_array(upgrade.bullet_effects)
	gun.bullet.collision_effects.append_array(upgrade.collision_effects)
	gun.bullet.hit_effects.append_array(upgrade.hit_effects)
	ui.update_upgrade(upgrades)


func _on_hitbox_hurt(_value: float) -> void:
	health_controller.take_damage(1)
	damaged.emit()
	hitbox.set_hittable(false)
	invulnerability_timer.start()
	ui.take_damage(health_controller.base_health, health_controller.get_health())
	modulate = Color(7, 4, 4)
	await get_tree().create_timer(.1).timeout
	modulate = Color.WHITE
	blink_timer.start()


func _on_invulnerability_timer_timeout() -> void:
	hitbox.set_hittable(true)
	blink_timer.stop()
	visible = true


func _on_sc_health_controller_died() -> void:
	died.emit()
	var instance: DeathScreen = deathScreen.instantiate()
	add_child(instance)


func _on_blink_timer_timeout() -> void:
	visible = not visible
