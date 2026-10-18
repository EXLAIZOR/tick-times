class_name HealthComponent
extends Node

signal health_changed(new_health: int)

@export var MAX_HEALTH : int = 5
@export var initial_health : int = 5
@export var ROOT : Node

var current_health : int

func _ready() -> void:
	current_health = initial_health

func apply_attack(attack : Attack):
	current_health -= attack.damage
	health_changed.emit(current_health)
	if current_health <= 0:
		get_tree().reload_current_scene()
