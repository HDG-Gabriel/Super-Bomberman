extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	choose_animation()


func choose_animation():
	var anim = ["Life", "Power", "Speed", "Bomb"]
	$AnimatedSprite.play(anim[randi()%4])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
