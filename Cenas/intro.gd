extends Control

# Tela de introdução do Fractal Kingdom
# Aparece depois do botão JOGAR, antes da seleção de fases
# Apresenta a missão do Pixel e ensina o básico de como jogar

func _ready() -> void:
	modulate = Color(1, 1, 1, 0)
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.5)


func _on_botao_comecar_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/selecao_fases.tscn")
