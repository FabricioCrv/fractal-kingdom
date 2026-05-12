extends Area2D
class_name EncaixeNumero

## Número esperado neste encaixe (ex: 3 para o numerador, 4 para o denominador)
@export var numero_esperado: int = 0
 
## AudioStreamPlayer2D para o som de encaixe
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
 
## Sprite ou nó visual do encaixe (anel/contorno)
@onready var sprite_encaixe: Sprite2D = $SpriteEncaixe
 
## Label que mostra o número esperado no cenário
@onready var label_esperado: Label = $NumeroEsperado
 
## Se o encaixe já está preenchido
var esta_preenchido: bool = false
 
## Referência ao bloco que está encaixado
var bloco_encaixado: BlocoNumero = null
 
## Emitido quando um bloco correto encaixa
signal bloco_encaixado_correto(encaixe: EncaixeNumero, bloco: BlocoNumero)
 
## Emitido quando um bloco é removido do encaixe
signal bloco_removido(encaixe: EncaixeNumero)
 
 
func _ready() -> void:
	add_to_group("encaixes")
	label_esperado.text = str(numero_esperado)
 

 
## Chamado pelo BlocoNumero em _atualizar_z_index, ou pelo próprio bloco ao terminar animação.
## Verifica se o bloco que chegou perto é o número correto.
func verificar_bloco_proximo(bloco: BlocoNumero) -> void:
	if esta_preenchido:
		return
 
	# Checa se o valor do bloco bate com o esperado
	if bloco.get("valor") == numero_esperado:
		_encaixar(bloco)
 
 
## Lógica de encaixe bem-sucedido
func _encaixar(bloco: BlocoNumero) -> void:
	esta_preenchido = true
	bloco_encaixado = bloco
 
	# Trava o bloco no centro do encaixe
	bloco.pushable = false
	var tween = get_tree().create_tween()
	tween.tween_property(bloco, "global_position", global_position, 0.15)
 
	# Som de encaixe
	if audio_player and audio_player.stream:
		audio_player.play()
 
	# Esconde o label de dica
	label_esperado.visible = false
 
	emit_signal("bloco_encaixado_correto", self, bloco)
 
 
## Permite desencaixar (opcional — remova se não quiser)
func desencaixar() -> void:
	if not esta_preenchido:
		return
	if bloco_encaixado:
		bloco_encaixado.pushable = true
	bloco_encaixado = null
	esta_preenchido = false
	label_esperado.visible = true
 
	emit_signal("bloco_removido", self)
 
 
## Retorna true se o encaixe está cheio com o bloco certo
func esta_correto() -> bool:
	return esta_preenchido


func _draw() -> void:
	draw_arc(Vector2.ZERO, 14, 0, TAU, 32, Color(1.0, 0.0, 0.0, 0.8), 3.0)
