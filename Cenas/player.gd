extends CharacterBody2D


@export var speed: float = 200.0
var screen_size: Vector2
var posicao_inicial: Vector2 = Vector2(640,690)


func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	
	position += velocity * speed * delta
	position.y = clamp(position.y, 0.0, screen_size.y)
	
	if velocity.y > 0:
		$AnimatedSprite2D.play("player_move_down")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("player_move_up")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("player_move_left")
	elif velocity.x > 0:
		$AnimatedSprite2D.play("player_move_right")
	else:
		$AnimatedSprite2D.stop()
	
