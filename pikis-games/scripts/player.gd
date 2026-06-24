extends CharacterBody2D


#@export var SPEED = 350.0
#@export var JUMP_VELOCITY = -600.0
var SPEED = 350.0
const JUMP_VELOCITY = -650.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var hud: CanvasLayer = $"../HUD"

# velocidade durante o power-up
const SPEED_BOOST = 400.0    
# segundos de duração   
const BOOST_DURATION = 5.0
# variável que controla quando o power-up está ativado ou não
var boosted = false

func _ready() -> void:
	print("Player criado")
	var vidas:int = 200
	print("VIDAS : "+str(vidas))
	
	var posicao_inical: Vector2 = Vector2(100, 100)
	


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Inverte o sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		
		# Altera a animação
	if is_on_floor():	
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("jump")
	
	move_and_slide()
func die():
	get_tree().reload_current_scene()
	#var speed = 200 (tipagem dinaminca)
	#var speed: int = 200 (tipagem explicita)
	#var speed := 200 (tipagem inferida pela Godot)
	#const speed = 200 (constante, nao pode ser alterada)
	
func apply_speed_boost():
		# Se a variável boosted for true
	if boosted:
		return  # Sai da função sem fazer nada
						# evita empilhar o efeito, ou seja, ter vários boosts de uma vez
	# Senão, se a variável boosted for false, segue e muda para true
	boosted = true
	# Altere a velocidade para o valor da varíavel SPEED_BOOST
	SPEED = SPEED_BOOST
	# Cria um timer com a duração da variável BOOST_DURATION e pausa a função
	# até que esse tempo termine
	await get_tree().create_timer(BOOST_DURATION).timeout
	# retorna a variável velocidade ao valor original
	SPEED = 200.0
	# volta a variável boosted para false, sinalizando que o power-up acabou
	boosted = false


func _on_powerup_speed_2_speed_collected(body: Variant) -> void:
	pass # Replace with function body.

# Recebe na função o nó que entrou na área e acessa o método que aplica o power-up
func _on_powerup_speed_speed_collected(body: Variant) -> void:
	if body.has_method("apply_speed_boost"):
		body.apply_speed_boost()
		
	# ... restante do código

func die2():
	tomar_dano(1)
# função que recebe a quantidade de dano via parâmetro e aplica à vidas
func tomar_dano(dano:int) -> void:
	GameManager.vidas -= dano
	if GameManager.vidas <= 0:
		print("Game Over")
	hud.atualizar_vidas()
