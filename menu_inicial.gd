extends Control

@onready var botao_jogar: Button = $BotaoJogar

func _ready() -> void:
	botao_jogar.pressed.connect(_on_botao_jogar_pressed)

func _on_botao_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/mundo.tscn")
