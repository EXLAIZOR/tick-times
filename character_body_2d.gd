extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var _animated_sprite = $AnimatedSprite2D
@onready var hitTimer = $hitTimer
@onready var attackedTimer = $attackedTimer
@onready var health_component: HealthComponent = $HealthComponent
var attacking = false
var attacked = false
var hearts_list : Array [TextureRect]
var bullet_path=preload("res://bullet.tscn")
var facing_direction = 1

func _process(_delta):
	handle_sprites()
func fire():
	var bullet = bullet_path.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position + Vector2(0,0)
	bullet.direction=facing_direction
	
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Attack"):
		fire()
		attacking = true
		hitTimer.start()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if Input.is_action_pressed("MoveRight"):
		facing_direction = 1
	elif Input.is_action_pressed("MoveLeft"):
		facing_direction = -1
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func handle_sprites():
	if attackedTimer.time_left > 0:
		_animated_sprite.play("injured")
	elif hitTimer.time_left > 0:
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

func _ready() -> void:
	var hearts_parent = $HP/HBoxContainer
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	print(hearts_list)
	for heart in hearts_list:
		var sprite = heart.get_node_or_null("AnimatedSprite2D")
		if sprite:
			sprite.play("default")
	
	if health_component:
		health_component.health_changed.connect(_on_health_changed)
		update_heart_display(health_component.current_health)

func _on_health_changed(new_health: int) -> void:
	update_heart_display(new_health)


func update_heart_display(new_health: int) -> void:
	for i in range(hearts_list.size()):
		var heart = hearts_list[i]
		var sprite = heart.get_node_or_null("AnimatedSprite2D")
		
		if sprite != null:
			if i < new_health:
				heart.visible = true
				sprite.play("default")
			else:
				if sprite.animation != "damaged":
					await get_tree().create_timer(0.1).timeout
					sprite.play("damaged")
					await get_tree().create_timer(0.2).timeout
					heart.visible = false
