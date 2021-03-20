extends KinematicBody2D

export var velocity = 200
var movement = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_player()

func move_player():
	if Input.is_action_pressed("ui_up"):
		movement = Vector2(0, -velocity)
	elif Input.is_action_just_pressed("ui_left"):
		movement = Vector2(-velocity, 0)
	elif Input.is_action_just_pressed("ui_down"):
		movement = Vector2(0, velocity)
	elif Input.is_action_just_pressed("ui_right"):
		movement = Vector2(velocity, 0)
	else:
		movement = Vector2()

	move_and_slide(movement)
