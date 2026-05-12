extends StaticBody2D
class_name BlocoNumero

@onready var ray_cast_2d: RayCast2D = $RayCast2D

## Valor numérico deste bloco (ex: 3 para o numerador "3")
@export var valor: int = 0

@export var pushable := false
@export var maxPushes := -1
var currentPushCount = 0


func _ready() -> void:
	ray_cast_2d.enabled = pushable


func push_block(direction):
	ray_cast_2d.target_position = direction * 25
	ray_cast_2d.force_raycast_update()

	if not pushable or ray_cast_2d.is_colliding():
		return

	_move_animation(global_position + direction * 25)
	currentPushCount += 1


func _move_animation(targetPosition):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", targetPosition, 0.5)
	tween.tween_callback(_verificar_encaixe)


func _verificar_encaixe() -> void:
	# Ajusta z_index se estiver sobre um encaixe
	var encaixes = get_tree().get_nodes_in_group("encaixes")
	for encaixe in encaixes:
		if encaixe.global_position.distance_to(global_position) < 16:
			z_index = encaixe.z_index + 1
			# Notifica o encaixe para verificar se este bloco é o correto
			if encaixe.has_method("verificar_bloco_proximo"):
				encaixe.verificar_bloco_proximo(self)
			return
	z_index = 0
