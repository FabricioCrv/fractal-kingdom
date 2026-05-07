extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_timer: Timer = $InteractionTimer

@export var speed: float = 200.0
var screen_size: Vector2
var posicao_inicial: Vector2 = Vector2(640,690)
var lastDirection: Vector2
var currentCollider: Node2D

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left","right","up","down")
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	
	var isColliding = move_and_slide()
	
	if isColliding and direction:
		if interaction_timer.is_stopped():
			interaction_timer.start()
		currentCollider = get_last_slide_collision().get_collider()
	else:
		interaction_timer.stop()
	
	_set_animation(direction)
	
	lastDirection = direction
		
		
	

func _set_animation(direction):
		
	if direction:
		if direction.y > 0:
			animated_sprite_2d.play("player_move_down")
		elif direction.y < 0:
			animated_sprite_2d.play("player_move_up")
		elif direction.x > 0:
			animated_sprite_2d.play("player_move_right")
		elif direction.x < 0:
			animated_sprite_2d.play("player_move_left")
		else:
			if lastDirection.y > 0:
				animated_sprite_2d.play("player_idle")
			elif lastDirection.y < 0:
				animated_sprite_2d.play("player_idle")
			elif lastDirection.x != 0:
				animated_sprite_2d.play("player_idle")


func _on_interaction_timer_timeout() -> void:
	if currentCollider is BlocoNumero:
		currentCollider.push_block(lastDirection)
