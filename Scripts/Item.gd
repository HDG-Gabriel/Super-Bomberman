extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	choose_animation()


func choose_animation():
	var anim = ["Life", "Power", "Speed", "Bomb"]
	$AnimatedSprite.play(anim[0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Item_body_entered(body: Node2D):
	if body is Player:
		$ItemCollected.play()
		$CollisionShape2D.set_deferred("disabled", true)
		hide()

		if $AnimatedSprite.animation == "Speed":
			buffer_speed(body)
		elif $AnimatedSprite.animation == "Bomb":
			earn_bomb(body)
		elif $AnimatedSprite.animation == "Life":
			earn_life(body)


# Aumenta a velocidade do jogador
func buffer_speed(body: Player):
	body.velocity += 20

# Adiciona uma vida ao jogador
func earn_life(body: Player):
	body.numero_de_vidas += 1

# Adiciona uma bomba ao jogador
func earn_bomb(body: Player):
	body.numero_bombas += 1

# Destroy o node atual
func _on_ItemCollected_finished():
	queue_free()
