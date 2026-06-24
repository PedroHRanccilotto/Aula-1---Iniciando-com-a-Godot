# Arquivo: powerup_speed.gd

extends Area2D

# sinal speed_collected criado já com o parâmetro body, que será 
# enviado junto ao sinal ao ser emitido, informando o nó que ouvir este sinal 
# todas as informações sobre o nó que entrou naquela área
signal speed_collected(body)

# Cria as variáveis que referenciam o nó de Partículas, Sprite2D e CollisionShape
@onready var particles: GPUParticles2D = $Particulas
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
		# recebe o próprio player como argumento, assim quem receber o sinal
		# tem acesso à todas as propriedades e métodos do player
	if body.name == "Player":
			# emite o sinal passando para quem receber o body, que será o meio de 
			# acesso ao Player
		speed_collected.emit(body)  
		# Deixa o coletável invisível
		sprite_2d.visible = false
		# desabilita o colisor
		collision_shape_2d.set_deferred("disabled", true)
		  # aguarda as partículas finalizarem
		await particles.finished
		# exclui o coletável da cena
		queue_free()
