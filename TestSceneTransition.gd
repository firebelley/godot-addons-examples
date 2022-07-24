extends Node


func _ready():
	$"%BackButton".connect("pressed", self, "on_back_button_pressed")


func on_back_button_pressed():
	ScreenTransition.transition_to_scene("res://TestScene.tscn")
