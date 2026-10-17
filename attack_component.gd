class_name AttackComponent
extends Area2D

@export var attack : Attack

func _init() -> void:
	set_collision_layer_value(3, true)
