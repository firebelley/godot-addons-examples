extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

var random_timer: Timer
var random_timer_button: Button

func _ready():
	random_timer_button = get_node("%RandomTimerButton")
	random_timer = get_node("RandomTimer")

	get_node("%RandomAudioStreamPlayerButton").connect("pressed", self, "on_random_audio_stream_player_pressed")
	random_timer_button.connect("pressed", self, "on_random_timer_pressed")


func _process(_delta):
	random_timer_button.text = "Start Random Timer" if random_timer.is_stopped() else "%.1f" % random_timer.time_left


func on_random_audio_stream_player_pressed():
	get_node("RandomAudioStreamPlayer").play()


func on_random_timer_pressed():
	random_timer.start()
