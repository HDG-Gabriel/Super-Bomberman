extends KinematicBody2D

class_name Player

export var velocity = 200
var movement = Vector2()

var is_death: bool = false
# Permite se o jogador pode tomar dano
var is_can_take_damage: bool = true
# Verifica se o jogador pode colocar bomba
var is_can_put_bomb: bool = true

# Estágio em que o jogador se encontra
var stage: Stage1

export (PackedScene) var Bomb

var life: int = 2
var totally_bombs: int = 1
var damage: int = 1

enum Direction {TOP, LEFT, DOWN, RIGHT}
var player_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	player_direction = Direction.DOWN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_death:
		move_player()

		if Input.is_action_pressed("ui_select"):
			create_bomb()

		if Input.is_action_pressed("ui_focus_next"):
			show_informations()

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


# Instancia um bomba
func create_bomb():
	if totally_bombs > 0 and is_can_put_bomb == true:
		is_can_put_bomb = false
		totally_bombs -= 1
		var bomb = Bomb.instance()
		bomb.stage = stage
		bomb.create(stage.player.position, self)

# Faz a animação de morrer
func death():
	is_death = true
	$AnimatedSprite.play("Death")


# Torna o player 'invencível' por alguns segundos
func be_invecible():
	is_can_take_damage = false
	$Invecible.start()


# Quando invencível, muda a cor do personagem
func change_color():
	if $AnimatedSprite.modulate == Color.white:
		$AnimatedSprite.modulate = "332c2c"
	else:
		$AnimatedSprite.modulate == Color.white


func show_informations():
	print("=========================================")
	print("Vidas(s):" + str(life))
	print("Total de bombas: " + str(totally_bombs))
	print("Velocidade: " + str(velocity))
	print("Dano: " + str(damage))


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Death":
		hide()


# Não é mais invecível
func _on_Invecible_timeout():
	is_can_take_damage = true
	$AnimatedSprite.modulate = Color.white


# Da dano no jogador
func take_damage():
	if is_can_take_damage:
		if life == 1:
			death()
		else:
			be_invecible()
			life -= 1
