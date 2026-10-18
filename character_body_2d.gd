extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var _animated_sprite = $AnimatedSprite2D
@onready var hitTimer = $hitTimer
var attacking = false
var attacked_timer = 3



func _process(_delta):
	handle_sprites()

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Attack"):
		attacking = true
		hitTimer.start()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func handle_sprites():
	if attacking == true:
		_animated_sprite.play("attack")
	elif not is_on_floor():
			if velocity.y < 0:
				_animated_sprite.play("jump_up")
			else:
				_animated_sprite.play("jump_down")
	elif abs(velocity.x) > 0:
			_animated_sprite.play("walk")
	else:
		_animated_sprite.play("idle")
	if Input.is_action_pressed("MoveLeft"):
		_animated_sprite.flip_h = true
	elif Input.is_action_pressed("MoveRight"):
		_animated_sprite.flip_h = false
	

func _on_hit_timer_timeout() -> void:
	attacking = false
