extends Node

## Scene Transitions Singleton

## Signals
signal fade_complete()


## Node References
@onready var fade_to_black: ColorRect = $CanvasLayer20/FadeToBlack
@onready var animation_player: AnimationPlayer = $AnimationPlayer


## Variables

## Intitialization
func _ready() -> void:
	fade_to_black.hide()


func fade_in() -> void:
	fade_to_black.show()
	animation_player.play("Scene_Transition")
	
	await animation_player.animation_finished
	fade_to_black.hide()


func fade_out() -> void:
	fade_to_black.show()
	animation_player.play_backwards("Scene_Transition")
	
	await animation_player.animation_finished
	fade_to_black.hide()
	
	
	fade_complete.emit()
