extends CharacterBody2D

var arrastando = false
var valor_fracao = 0.5 # Representa 1/2 ou 2/4 do seu GDD

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and is_mouse_over():
				arrastando = true
			else:
				arrastando = false

func _process(_delta):
	if arrastando:
		global_position = get_global_mouse_position()

func is_mouse_over():
	# Calcula se o mouse está em cima do retângulo de colisão
	var mouse_pos = get_local_mouse_position()
	return $CollisionShape2D.shape.get_rect().has_point(mouse_pos)
