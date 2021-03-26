extends StaticBody2D

class_name Bomb

export (PackedScene) var Explosion

var stage

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Bomb")
	$PutBomb.play()
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	player.totally_bombs += 1
	var explosion = Explosion.instance()
	explosion.stage = stage
	explosion.create_explosion(position)
	queue_free()

# Cria uma bomba
func create(pos: Vector2, player: Node2D):
	self.player = player
	position.x = int(round(pos.x)/16) * 16 + 8
	position.y = int(ceil(pos.y - 1)/16) * 16 + 8
	stage.add_child_below_node(stage.get_node("Ground"), self)

func _on_Area2D_body_exited(body):
	# Ativa a colisão
	$CollisionShape2D.set_deferred("disabled", false)
	
	if body is Player:
		body.is_can_put_bomb = true
