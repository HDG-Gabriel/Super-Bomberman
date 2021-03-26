extends Node2D

var stage: Stage1

# Called when the node enters the scene tree for the first time.
func _ready():
	# Por padrão a explosão inicia oculta, para que quando
	# parte coloidir com outras coisas, a chama seja destruída
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_explosion(pos: Vector2):
	stage.add_child_below_node(stage.get_node("Wall"), self)
	$SoundExplosion.play()
	$"Center".position = pos
	explosion_position(pos)
	$Center.get_node("AnimatedSprite").play("Center")

	$Stub.queue_free()

# Configura o tamanho da explosão
func explosion_position(pos_bomb: Vector2):
	# Rotação
	var rot = 0
	
	var positions = [Vector2(0, 14), Vector2(-15, -1), Vector2(0, -15), Vector2(15, 0)]
	var node = []
	for i in range(0, 4):
		node.append($Stub.duplicate())
		node[i].position = pos_bomb + positions[i]
		add_child(node[i])
		
		node[i].get_node("AnimatedSprite").play("Stub")

		if i > 0:
			rot += 90
			node[i].get_node("AnimatedSprite").rotation_degrees = rot
			
			# Rotaciona o colisor tbm
			if (rot / 90) % 2 == 1:
				node[i].get_node("CollisionShape2D").rotation_degrees = 90


func _on_Center_body_entered(body: Node2D):
	kill_player(body)


func _on_Stub_body_entered(body):
	kill_player(body)


func kill_player(body):
	if body is Player:
		body.death()


# Quando a animação de explosão terminar ela será destruida
func _on_AnimatedSprite_animation_finished():
	queue_free()

