extends Node2D

@onready var ponte = $ponte

# Deixe a ponte invisível e sem colisão logo que o jogo começa
func _ready():
	ponte.visible = false
	ponte.get_node("CollisionShape2D").disabled = true

func abrir_ponte():
	ponte.visible = true
	ponte.get_node("CollisionShape2D").set_deferred("disabled", false)
	print("Equivalência correta! Ponte aberta.")


func _on_area_2d_body_entered(body: Node2D) -> void:
	# Verifica se quem entrou na área foi o bloco certo
	if body.name == "BlocoFracao":
		# Verifica se a fração resolve o puzzle
		if body.valor_fracao == 0.5: 
			abrir_ponte()
		else:
			print("Fração errada!")
