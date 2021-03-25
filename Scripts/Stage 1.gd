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
	create_walls()


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
			var block = create_block(Vector2(i, j))
			
			# Posições não permitidas
			if Vector2(i, j) in block_positions:
				block.queue_free()
			
			aleatory_block(block)

	# Preenche verticalmente
	for i in range(56, 56 + 15*16, 32):
		for j in range(40, 40 + 16*9, 32):
			var block = create_block(Vector2(i, j))

			# Posições não permitidas
			if Vector2(i, j) in block_positions:
				block.queue_free()

			aleatory_block(block)


func create_block(pos: Vector2) -> Node2D:
	var block = Block.instance()
	block.stage = self
	block.position = pos
	add_child(block)
	return block

# Cria as paresdes que circundam a cena
func create_walls():
	create_walls_in_interior()
	
	# Cria blocos na horinzontal
	for i in range(40, 296 + 1, 16):
		create_individual_wall(Vector2(i, 8))
		create_individual_wall(Vector2(i, 200))
	# Cria blocos na vertical
	for j in range(24, 184 + 1, 16):
		create_individual_wall(Vector2(40, j))
		create_individual_wall(Vector2(296, j))


func create_individual_wall(pos: Vector2):
	var wall = Wall.instance()
	add_child_below_node($Ground, wall)
	wall.position = Vector2(pos)

# Cria as paredes internas da arena
func create_walls_in_interior():
	for i in range(72, 264 + 1, 32):
		for j in range(40, 168 + 1, 32):
			var wall = Wall.instance()
			add_child_below_node($Ground, wall)
			wall.position = Vector2(i, j)


# Tem a probabilidade quebrar um bloco
func aleatory_block(block: Node2D):
	var random =  1 + randi()%10   #[1, 10]
	
	if random < 2:
		block.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
