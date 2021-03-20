extends Node2D

export (PackedScene) var Player

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = Player.instance()
	player.position = Vector2(72, -16)
	add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
