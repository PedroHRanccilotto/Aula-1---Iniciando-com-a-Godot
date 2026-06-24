# Arquivo hud.gd
extends CanvasLayer
# variável referenciando a label de vidas
@onready var health_label: Label = $Control/HealthLabel
# Quando carregar na cena, chamar a função atualizar_vidas()
func _ready() -> void:
	atualizar_vidas()
# função que atualiza a label para o valor da variável vidas no GameManager
func atualizar_vidas() -> void:
	health_label.text = "Vidas: " + str(GameManager.vidas)
	
