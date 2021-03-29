extends Node2D

var stage: Stage1

# Sentido: baixo, esquerda, cima, direita
var sides = [Vector2(0, 16), Vector2(-16, 0), Vector2(0, -16), Vector2(16, 0)]

# Determina o tamanho da explosão
var damage: int

# Called when the node enters the scene tree for the first time.
func _ready():
	# Por padrão a explosão inicia oculta, para que quando
	# parte colidir com outras coisas, a chama seja destruída
	damage = stage.player.damage


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_explosion(pos: Vector2):
	stage.add_child_below_node(stage.get_node("Wall"), self)
	#$SoundExplosion.play()
	$"Center".position = pos
	create_body_explosion()
	create_stubs()
	destroy_nodes()


func create_body_explosion():
	for i in range(0, 4):
		if i % 2 == 0:
			for j in range(1, damage + 1):
				create_node($Tail_Vertical, $Center.position + j*sides[i])
		else:
			for j in range(1, damage + 1):
				create_node($Tail_Horizontal, $Center.position + j*sides[i])


func create_node(area: Area2D, pos: Vector2):
	var node = area.duplicate()
	node.position = pos
	add_child(node)


# Cria as "pontas" da explosão
func create_stubs():
	pass


# Verifica se pode matar o player, se puder, mata,
# Senão diminui a vida :d
func kill_player(body):
	if body is Player:
		body.take_damage()


func destroy_nodes():
	var nodes = [$Tail_Horizontal, $Tail_Vertical,
	$Stub_Down, $Stub_Left, $Stub_Right, $Stub_Up]

	for node in nodes:
		node.queue_free()
