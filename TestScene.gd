extends Node

var random_timer: RandomTimer
var random_timer_button: Button


func _ready():
	randomize()

	random_timer_button = $"%RandomTimerButton"
	random_timer = $"RandomTimer"

	$"%RandomAudioStreamPlayerButton".connect("pressed",Callable(self,"on_random_audio_stream_player_pressed"))
	$"%RandomAudioStreamPlayer2DButton".connect("pressed",Callable(self,"on_random_audio_stream_player_2d_pressed"))
	$"%ScreenTransitionButton".connect("pressed",Callable(self,"on_screen_transition_pressed"))
	$"%ShakyCamera2DButton".connect("pressed",Callable(self,"on_shaky_camera_2d_pressed"))
	random_timer_button.connect("pressed",Callable(self,"on_random_timer_pressed"))


func _process(_delta):
	random_timer_button.text = "Start Random Timer" if random_timer.is_stopped() else "%.1f" % random_timer.time_left


func on_random_audio_stream_player_pressed():
	%RandomAudioStreamPlayer.play_random()


func on_random_audio_stream_player_2d_pressed():
	%RandomAudioStreamPlayer2D.play_random()


func on_random_timer_pressed():
	random_timer.start_random()


func on_screen_transition_pressed():
	var colors = [
		Color.BLACK,
		Color.BLUE_VIOLET,
		Color.GOLDENROD,
		Color.ALICE_BLUE,
		Color.SIENNA
	]

	var textures = [
		load("res://addons/node_library/assets/transition-texture.png"),
		load("res://assets/textures/screen-transition-alternate.png"),
		load("res://assets/textures/screen-transition-alternate2.png")
	]

	var color_index = randi() % colors.size()
	var texture_index = randi() % textures.size()

	ScreenTransition.set_transition_color(colors[color_index])
	ScreenTransition.set_transition_texture(textures[texture_index])
	ScreenTransition.transition_to_scene("res://TestSceneTransition.tscn")


func on_shaky_camera_2d_pressed():
	$ShakyCamera2D.shake()
