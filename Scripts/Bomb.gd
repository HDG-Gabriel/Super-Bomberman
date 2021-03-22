extends StaticBody2D

class_name Bomb

export (PackedScene) var Explosion

var stage: Stage1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Bomb")
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	var explosion = Explosion.instance()
	explosion.stage = stage
	#explosion.create_explosion(position)
	queue_free()

func _on_Area2D_body_exited(body):
	# Ativa a colisão
	$CollisionShape2D.set_deferred("disabled", false)
