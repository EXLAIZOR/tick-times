class_name HitboxComponent
extends Area2D

@export var health_component : HealthComponent

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area : Area2D):
	if area is AttackComponent:
		health_component.apply_attack(area.attack)
