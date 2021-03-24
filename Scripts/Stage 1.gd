extends Node2D

class_name Stage1

export (PackedScene) var Player
export (PackedScene) var Block
export (PackedScene) var Wall

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	# Permite a criação de números pseudo-aleatórios
	randomize()

	create_blocks()
	create_player()


# Cria um jogador
func create_player():
	player = Player.instance()
	player.stage = self
	player.position = Vector2(56, 20)
	add_child(player)


# Cria os blocos para a arena
func create_blocks():
	# Posições especiais onde não pode ter blocos
	var block_positions = [
		Vector2(56, 24), Vector2(72, 24), Vector2(56, 40),
		Vector2(280, 24), Vector2(280, 40), Vector2(264, 24),
		Vector2(56, 184), Vector2(72, 184), Vector2(56, 168),
		Vector2(280, 184), Vector2(264, 184), Vector2(280, 168)]
	
	# Preenche horizontalmente
	for i in range(56, 56 + 15*16, 16):
		for j in range(24, 24 + 11*16, 32):
			var block = Block.instance()
			var block_pos = Vector2(i, j)
			block.position = block_pos
			add_child(block)
			
			# Posições não permitidas
			if block_pos in block_positions:
				block.queue_free()
			
			aleatory_block(block)

	# Preenche verticalmente
	for i in range(56, 56 + 15*16, 32):
		for j in range(40, 40 + 16*9, 32):
			var block = Block.instance()
			var pos = Vector2(i, j)
			block.position = pos
			add_child(block)

			# Posições não permitidas
			if pos in block_positions:
				block.queue_free()

			aleatory_block(block)


# Cria as paresdes que circundam a cena
func create_walls():
	var wall = Wall.instance()
	add_child(wall)
	wall.position = Vector2(40, 8)


# Tem a probabilidade quebrar um bloco
func aleatory_block(block: Node2D):
	var random =  1 + randi()%10   #[1, 10]
	
	if random < 2:
		block.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
