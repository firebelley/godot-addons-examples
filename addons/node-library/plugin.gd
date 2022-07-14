tool
extends EditorPlugin

const RANDOM_AUDIO_STREAM_PLAYER = "RandomAudioStreamPlayer"
const RANDOM_TIMER = "RandomTimer"

func _enter_tree():
	add_custom_type(RANDOM_AUDIO_STREAM_PLAYER, "Node", preload("scripts/random_audio_stream_player.gd"), null)
	add_custom_type(RANDOM_TIMER, "Timer", preload("scripts/random_timer.gd"), null)

func _exit_tree():
	remove_custom_type(RANDOM_AUDIO_STREAM_PLAYER)
	remove_custom_type(RANDOM_TIMER)
