extends CharacterBody2D

const SPEED = 80.0
const GRAVITY = 800.0

var direction = 1

# Variáveis que referenciam os nós da cena
@onready var floor_left: RayCast2D = $floorleft
@onready var floor_right: RayCast2D = $floorright
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	# Garante que a gravidade seja aplicada ao inimigo caso ele não esteja no chão
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if not floor_left.is_colliding():
		direction = 1
	if not floor_right.is_colliding():
		direction = -1
	# Aplica velocidade no eixo x
	velocity.x = direction * SPEED
	
	# Vira o sprite do personagem se estiver indo para a direita
	anim.flip_h = direction > 0
	
	# Roda a animação de caminhar
	anim.play("walk")
	
	# Move o inimigo
	move_and_slide()
	
func _on_timer_timeout() -> void:
	# Quando o tempo acabar, inverte a direção do inimigo
	direction *= -1
