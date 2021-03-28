extends Node2D

var stage: Stage1

# Determina o tamanho da explosão
var damage: int

# Called when the node enters the scene tree for the first time.
func _ready():
	# Por padrão a explosão inicia oculta, para que quando
	# parte coloidir com outras coisas, a chama seja destruída
	hide()
	$Timer.start()
	damage = stage.player.damage


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_explosion(pos: Vector2):
	stage.add_child_below_node(stage.get_node("Wall"), self)
	$SoundExplosion.play()
	$"Center".position = pos
	$Center.get_node("AnimatedSprite").play("Center")


func _on_Center_body_entered(body):
	kill_player(body)


func _on_Stub_body_entered(body):
	kill_player(body)


# Verifica se pode matar o player, se puder, mata,
# Senão diminui a vida :d
func kill_player(body):
	if body is Player:
		body.take_damage()


# Quando a animação de explosão terminar ela será destruida
func _on_AnimatedSprite_animation_finished():
	queue_free()


# Torna vísivel a explosão, se não colidir com nada
func _on_Timer_timeout():
	if visible == false:
		show()
