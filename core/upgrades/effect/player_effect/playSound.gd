class_name PlaySound
extends PlayerEffect

@export var stream: AudioStream

func apply(player: Player) -> void:
	var audio: AudioStreamPlayer = AudioStreamPlayer.new()
	audio.stream = stream
	audio.autoplay = true
	audio.finished.connect(audio.queue_free)
	player.add_sibling(audio)
