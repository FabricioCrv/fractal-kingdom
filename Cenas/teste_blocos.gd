extends Node2D
class_name LevelManager

var bloco_scene = preload("res://Cenas/bloco_numero.tscn")
var encaixe_scene = preload("res://Cenas/encaixe_numero.tscn")

# Dados da fase: fração alvo é 3/4
# blocos disponíveis e onde começam
var fase_atual = {
	"fracao": [3, 4],  # numerador, denominador
	"blocos": [
		{"valor": 3, "pos": Vector2(100, 200)},
		{"valor": 4, "pos": Vector2(150, 200)},
		{"valor": 7, "pos": Vector2(200, 200)},  # distrator
	],
	"encaixes": [
		{"esperado": 3, "pos": Vector2(300, 150)},  # numerador
		{"esperado": 4, "pos": Vector2(300, 250)},  # denominador
	]
}

func _ready() -> void:
	carregar_fase(fase_atual)
	
func carregar_fase(dados: Dictionary) -> void:
	for b in dados["blocos"]:
		criar_bloco(b["valor"], b["pos"])
	for e in dados["encaixes"]:
		var encaixe = criar_encaixe(e["esperado"], e["pos"])
		encaixe.bloco_encaixado_correto.connect(_on_bloco_encaixado)

func criar_bloco(valor: int, posicao: Vector2) -> BlocoNumero:
	var bloco = bloco_scene.instantiate()
	bloco.valor = valor
	bloco.global_position = posicao
	bloco.pushable = true
	add_child(bloco)
	return bloco

func criar_encaixe(numero_esperado: int, posicao: Vector2) -> EncaixeNumero:
	var encaixe = encaixe_scene.instantiate()
	encaixe.numero_esperado = numero_esperado
	encaixe.global_position = posicao
	add_child(encaixe)
	return encaixe

var encaixes_completos = 0

func _on_bloco_encaixado(_encaixe, _bloco) -> void:
	encaixes_completos += 1
	if encaixes_completos >= fase_atual["encaixes"].size():
		avancar_fase()

func avancar_fase() -> void:
	print("Fase completa! Avançando...")
	# get_tree().change_scene_to_file("res://ProximaFase.tscn")
