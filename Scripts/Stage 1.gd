extends Node2D

class_name Stage1

export (PackedScene) var Player

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	create_player()

# Cria um jogador
func create_player():
	player = Player.instance()
	player.stage = self
	player.position = Vector2(72, -16)
	add_child(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
