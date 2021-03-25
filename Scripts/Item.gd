extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	choose_animation()


func choose_animation():
	var anim = ["Life", "Power", "Speed", "Bomb"]
	$AnimatedSprite.play(anim[2])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Item_body_entered(body):
	if body.is_in_group("Player"):
		if $AnimatedSprite.animation == "Speed":
			buffer_speed(body)


# Aumenta a velocidade do jogador
func buffer_speed(body: Node2D):
	$CollisionShape2D.set_deferred("disabled", true)
	body.velocity += 20
	queue_free()
