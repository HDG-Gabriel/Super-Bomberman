extends Area2D

var stage: Stage1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_explosion(pos: Vector2):
	# Configura a posição
	pos -= Vector2(32, 2)
	explosion_position(pos)
	stage.add_child_below_node(stage.get_node("Wall"), self)


# Configura o tamanho da explosão
func explosion_position(pos_bomb: Vector2):
	# Rotação
	var rot = 0
	$".".position = pos_bomb
	var positions = [Vector2(0, 16), Vector2(-16, 0), Vector2(0, -16), Vector2(16, 0)]
	var node = []
	for i in range(0, 4):
		node.append($Stub.duplicate())
		node[i].position = pos_bomb + positions[i]
		add_child(node[i])
		
		if i > 0:
			rot += 90
			node[i].get_node("Sprite").rotation_degrees = rot
