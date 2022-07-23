extends Node

var random_timer: Timer
var random_timer_button: Button


func _ready():
	random_timer_button = get_node("%RandomTimerButton")
	random_timer = get_node("RandomTimer")

	get_node("%RandomAudioStreamPlayerButton").connect("pressed", self, "on_random_audio_stream_player_pressed")
	get_node("%RandomAudioStreamPlayer2DButton").connect("pressed", self, "on_random_audio_stream_player_2d_pressed")
	random_timer_button.connect("pressed", self, "on_random_timer_pressed")

	ScreenTransition.set_transition_color(Color.aliceblue)
	ScreenTransition.transition()
	yield(ScreenTransition, "transitioned_halfway")
	print("yep")


func _process(_delta):
	random_timer_button.text = "Start Random Timer" if random_timer.is_stopped() else "%.1f" % random_timer.time_left


func on_random_audio_stream_player_pressed():
	get_node("RandomAudioStreamPlayer").play()


func on_random_audio_stream_player_2d_pressed():
	get_node("%RandomAudioStreamPlayer2D").play()


func on_random_timer_pressed():
	random_timer.start()
