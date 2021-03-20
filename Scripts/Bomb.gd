extends Area2D

class_name Bomb

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Bomb")
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	queue_free()


func _on_Bomb_body_exited(body):
	print("ShEiPado")
	$CollisionShape2D.set_deferred("enable", true)
