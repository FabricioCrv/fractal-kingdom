extends Control

# Tela de seleção de fases
# Cada card é um botão clicável (toda a área do card responde ao clique)

func _ready() -> void:
	modulate = Color(1, 1, 1, 0)
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.4)


func _on_botao_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/menu_inicial.tscn")


func _on_botao_fase_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fase_1.tscn")


func _on_botao_fase_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fase_2.tscn")


func _on_botao_fase_3_pressed() -> void:
	# Quando criar Cenas/fase_3.tscn, descomente a linha abaixo
	# get_tree().change_scene_to_file("res://Cenas/fase_3.tscn")
	print("Crie Cenas/fase_3.tscn primeiro")
