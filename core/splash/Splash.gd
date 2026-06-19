class_name Splash
extends Control

var url: String = "res://core/main/Main.tscn"
var animation_name: String = "Start"

@onready var animation: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation.play(animation_name)


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		go_to_menu()


func go_to_menu() -> void:
	get_tree().change_scene_to_file(url)


func _on_animation_player_animation_finished(_anim_name: String) -> void:
	go_to_menu()
