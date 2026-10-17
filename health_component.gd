class_name HealthComponent
extends Node

@export var MAX_HEALTH : int = 5
@export var initial_health : int = 5
@export var ROOT : Node

var current_health : int

func apply_attack(attack : Attack):
	current_health -= attack.damage
	
	if current_health == 0:
		ROOT.queue_free()
