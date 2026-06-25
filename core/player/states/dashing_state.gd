class_name DashingState
extends State

var dash_direction: Vector2
var dash_duration: Timer


func _init(new_target: Player, direction: Vector2, duration: float) -> void:
	self.target = new_target
	self.dash_direction = direction
	target.get_tree().create_timer(duration).timeout.connect(_on_duration_end)


func on_enter() -> void:
	target.sc_physics_controller.set_physics_process(false)
	target.hitbox.set_hittable(false)

func on_exit() -> void:
	target.sc_physics_controller.set_physics_process(true)
	target.velocity = dash_direction * target.sc_physics_controller.max_speed
	target.hitbox.set_hittable(true)
	target.dash_cd_sprite.visible = true
	var tween: Tween = target.get_tree().create_tween()
	tween.tween_method(_set_dash_progress, 0.0, 1.0, target.dash_cooldown.wait_time)
	await target.get_tree().create_timer(target.dash_cooldown.wait_time).timeout
	target.dash_cd_sprite.visible = false

func _set_dash_progress(value: float) -> void:
	target.dash_cd_shader.set_shader_parameter("progress", value)

func physics_process(delta: float) -> void:
	target.velocity = target.velocity.move_toward(target.DASH_SPEED * dash_direction, delta * target.DASH_ACCELERATION)
	target.move_and_slide()


func _on_duration_end() -> void:
	target.update_current_state(MovingState.new(target, dash_direction))
