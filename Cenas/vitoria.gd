extends Control

# Tela de vitória REUTILIZÁVEL — serve para todas as fases
#
# COMO USAR (a partir de qualquer fase):
#   Vitoria.fase_completada = 1                        # número da fase que terminou
#   Vitoria.proxima_cena = "res://Cenas/mundo.tscn"    # cena da próxima fase
#   get_tree().change_scene_to_file("res://Cenas/vitoria.tscn")
#
# Se não houver próxima fase (ex.: portal final), deixe proxima_cena = ""
# que o botão "PRÓXIMA FASE" some automaticamente.

# Variáveis estáticas: mantêm o valor entre as trocas de cena
static var fase_completada: int = 1
static var proxima_cena: String = ""
static var frase: String = ""


func _ready() -> void:
	# Configura os textos com base no que a fase definiu
	$TituloFase.text = "FASE %d" % fase_completada

	# Frase temática: usa a personalizada se houver, senão usa uma padrão
	if frase != "":
		$FraseTematica.text = frase
	else:
		$FraseTematica.text = "Você restaurou mais um fragmento de Numeria!"

	# Se não há próxima cena definida, esconde o botão "PRÓXIMA FASE"
	# e centraliza o botão "MENU"
	if proxima_cena == "":
		$BotaoProxima.visible = false
		$BotaoMenu.offset_left = -140.0
		$BotaoMenu.offset_right = 140.0

	# Fade-in suave
	modulate = Color(1, 1, 1, 0)
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.5)


func _on_botao_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/menu_inicial.tscn")


func _on_botao_proxima_pressed() -> void:
	if proxima_cena != "":
		get_tree().change_scene_to_file(proxima_cena)
	else:
		# Segurança: se por algum motivo não tiver próxima cena, volta pro menu
		get_tree().change_scene_to_file("res://Cenas/menu_inicial.tscn")
