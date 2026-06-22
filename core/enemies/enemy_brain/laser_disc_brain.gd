class_name LaserDiscBrain
extends EnemyBrain

enum BrainState {
	START,
	IDLE,
	SEEKING,
	LOADING,
	SHOOTING,
}

@export var idle_duration: float = 3
@export var seeking_duration: float = 3
@export var loading_duration: float = 0.4
@export var attack: EnemyDiscreteAttack

var current_state: BrainState = BrainState.START
var state_ended: bool = false
var beam: Line2D = Line2D.new()
var marker: Marker2D = Marker2D.new()


func change_state(entity: EnemyEntity) -> void:
	match current_state:
		BrainState.START:
			current_state = BrainState.IDLE
			entity.get_tree().create_timer(idle_duration).timeout.connect(end_state)
		BrainState.IDLE:
			current_state = BrainState.SEEKING
			beam = Line2D.new()
			beam.width = 10
			beam.default_color = Color.RED
			entity.add_child(beam)
			entity.get_tree().create_timer(seeking_duration).timeout.connect(end_state)
		BrainState.SEEKING:
			current_state = BrainState.LOADING
			beam.default_color = Color.BLUE
			beam.points = []
			beam.add_point(beam.to_local(entity.global_position))
			beam.add_point(beam.to_local(entity.target.position))
			marker = Marker2D.new()
			marker.global_position = entity.target.position
			entity.get_tree().create_timer(loading_duration).timeout.connect(end_state)
		BrainState.LOADING:
			current_state = BrainState.SHOOTING
		BrainState.SHOOTING:
			current_state = BrainState.IDLE
			entity.get_tree().create_timer(idle_duration).timeout.connect(end_state)

func end_state() -> void:
	state_ended = true

func process(entity: EnemyEntity, _delta: float) -> void:
	if state_ended:
		state_ended = false
		change_state(entity)
	if current_state == BrainState.START:
		state_ended = true
	elif current_state == BrainState.SEEKING:
		beam.points = []
		beam.add_point(beam.to_local(entity.global_position))
		beam.add_point(beam.to_local(entity.target.position))
	elif current_state == BrainState.SHOOTING:
		beam.free()
		var target_temp: Node2D = entity.target
		entity.target = marker
		attack.attack(entity)
		entity.target = target_temp
		marker.free()
		state_ended = true
