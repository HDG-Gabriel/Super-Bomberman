extends KinematicBody2D

export var velocity = 200
var movement = Vector2()

enum Direction {TOP, LEFT, DOWN, RIGHT}
var player_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	player_direction = Direction.DOWN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_player()
	
	# Se está se movendo
	if movement != Vector2():
		change_direction()
	else:
		change_direction_idle()

# Cuida da movimentação do player
func move_player():
	if Input.is_action_pressed("ui_up"):
		movement = Vector2(0, -velocity)
		player_direction = Direction.TOP
	elif Input.is_action_pressed("ui_left"):
		movement = Vector2(-velocity, 0)
		player_direction = Direction.LEFT
	elif Input.is_action_pressed("ui_down"):
		movement = Vector2(0, velocity)
		player_direction = Direction.DOWN
	elif Input.is_action_pressed("ui_right"):
		movement = Vector2(velocity, 0)
		player_direction = Direction.RIGHT
	# Jogador está parado
	else:
		movement = Vector2()
	movement = move_and_slide(movement)

# Seleciona a animação para quando o jogador estiver parado
func change_direction_idle():
	if player_direction == Direction.TOP:
		$AnimatedSprite.play("Idle_Top")
	elif player_direction == Direction.LEFT:
		$AnimatedSprite.play("Idle_Left")
	elif player_direction == Direction.DOWN:
		$AnimatedSprite.play("Idle_Down")
	elif player_direction == Direction.RIGHT:
		$AnimatedSprite.play("Idle_Right")

# Seleciona qual a animação deve iniciar com base no movimento
func change_direction():
	# Animação de andar pra cima
	if player_direction == Direction.TOP:
		$AnimatedSprite.play("Top")
	# Andar para a esquerda
	elif player_direction == Direction.LEFT:
		$AnimatedSprite.play("Left")
	# Animação de descer
	elif player_direction == Direction.DOWN:
		$AnimatedSprite.play("Down")
	# Animação de andar para direita
	elif player_direction == Direction.RIGHT:
		$AnimatedSprite.play("Right")
