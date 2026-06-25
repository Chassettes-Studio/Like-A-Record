class_name Player
extends CharacterBody2D

signal died
signal damaged

static var static_character: Character

@export var DASH_SPEED: float = 2_000
@export var DASH_ACCELERATION: float = 50_000

@export var upgrades: Array[Upgrade] = []

@export var character: Character

var current_state: State = MovingState.new(self, Vector2.RIGHT)
var deathScreen: PackedScene = preload("res://core/ui/death/DeathScreen.tscn")
var dash_unlocked := false

var energy: int = 0

var player_shoot_effects: Array[PlayerShootEffect] = []

@onready var blink_timer: Timer = $BlinkTimer
@onready var player_sprite: Sprite2D = $PlayerSprite

@onready var hitbox: Hitbox = $Hitbox

@onready var health_controller: SCHealthController = $SCHealthController
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer

@onready var sc_physics_controller: SCPhysicsController = $SCPhysicsController
@onready var dash_cooldown: Timer = $DashCooldown
@onready var gun: Gun = $Gun
@onready var ui: PlayerUi = $PlayerUi
@onready var hit: AudioStreamPlayer = $Hit
@onready var dash_cd_sprite: Sprite2D = $dashCdSprite

var dash_duration := .2
var dash_cd_shader: ShaderMaterial

func _ready() -> void:
	gun.shot.connect(_on_gun_shot)
	if static_character != null:
		character = static_character
	player_sprite.texture = character.texture
	ui.set_texture(character.texture)
	dash_cd_shader = dash_cd_sprite.material as ShaderMaterial

func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)
	if Input.is_action_just_pressed("shoot"):
		gun.shoot(Vector2.RIGHT.rotated(gun.rotation))
	if Input.is_action_just_pressed("use_ability"):
		if energy >= 3:
			energy -= 3
			character.ability.use(self)
			ui.set_energy(energy)


func update_current_state(state: State) -> void:
	self.current_state.on_exit()
	self.current_state = state
	self.current_state.on_enter()


func apply_upgrade(upgrade: Upgrade) -> void:
	upgrades.push_front(upgrade)
	player_shoot_effects.append_array(upgrade.player_shoot_effects)
	for p_effect in upgrade.player_effects:
		p_effect.apply(self)
	for g_effect in upgrade.gun_effects:
		g_effect.apply(self.gun)
	gun.bullet.bullet_effects.append_array(upgrade.bullet_effects)
	gun.bullet.collision_effects.append_array(upgrade.collision_effects)
	gun.bullet.hit_effects.append_array(upgrade.hit_effects)
	gun.bullet.bullet_process_effect.append_array(upgrade.bullet_process_effects)
	ui.update_upgrade(upgrades)


func _on_gun_shot() -> void:
	for effect in player_shoot_effects:
		effect.apply(self)


func _on_hitbox_hurt(value: float) -> void:
	hit.play()
	health_controller.take_damage(int(value))
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
	player_sprite.modulate.a = 1


func _on_sc_health_controller_died() -> void:
	died.emit()
	var instance: DeathScreen = deathScreen.instantiate()
	add_child(instance)


func _on_blink_timer_timeout() -> void:
	player_sprite.modulate.a = 1 - player_sprite.modulate.a


func _on_sc_health_controller_healed() -> void:
	ui.take_damage(health_controller.base_health, health_controller.get_health())


func _on_dash_cooldown_timeout() -> void:
	dash_cd_sprite.visible = false
