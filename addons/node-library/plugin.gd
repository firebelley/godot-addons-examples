tool
extends EditorPlugin

const NAME = "RandomAudioStreamPlayer"

func _enter_tree():
	add_custom_type(NAME, "Node", preload("scripts/random_audio_stream_player.gd"), null)

func _exit_tree():
	remove_custom_type(NAME)
