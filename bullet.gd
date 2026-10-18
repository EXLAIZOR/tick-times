extends Node2D
@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	position.x += 400 * delta
	_animated_sprite.play("default")
