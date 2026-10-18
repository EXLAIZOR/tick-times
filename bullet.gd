extends Node2D
@onready var _animated_sprite = $AnimatedSprite2D


var speed = 400
var direction: int =1

func _physics_process(delta: float) -> void:
	position.x += direction * speed * delta

	_animated_sprite.play("default")
