extends CharacterBody2D


#@export var SPEED = 350.0
#@export var JUMP_VELOCITY = -600.0
const SPEED = 350.0
const JUMP_VELOCITY = -650.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


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
	
	#var speed = 200 (tipagem dinaminca)
	#var speed: int = 200 (tipagem explicita)
	#var speed := 200 (tipagem inferida pela Godot)
	#const speed = 200 (constante, nao pode ser alterada)
	
