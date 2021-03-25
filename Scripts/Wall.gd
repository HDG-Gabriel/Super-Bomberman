extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area: Area2D):
	if area.is_in_group("Explosion"):
		var father: Node2D = area.get_parent() 
		area.queue_free()
		father.show()
