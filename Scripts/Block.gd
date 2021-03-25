extends StaticBody2D

var stage: Stage1

export (PackedScene) var Item

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Normal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Ativa a animação de destruição
func destroy():
	$AnimatedSprite.play("Exploding")


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Exploding":
		create_item()
		queue_free()


func _on_Area2D_area_entered(area: Area2D):
	# Destroi a explosão para não sobrepor ao block
	if area.is_in_group("Explosion"):
		if area.get_parent().visible == false:
			area.get_parent().visible = true
		area.queue_free()
		destroy()


func create_item():
	var item = Item.instance()
	stage.add_child_below_node(stage.get_node("Wall"), item)
	item.position = position
