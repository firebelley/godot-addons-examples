extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("%RandomAudioStreamPlayerButton").connect("pressed", self, "on_random_audio_stream_player_pressed")

func on_random_audio_stream_player_pressed():
	get_node("RandomAudioStreamPlayer").play()
