extends Node2D

export (bool) var stoped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if(stoped):
		return
	
	if(position.x < -1280):
		queue_free()
	else:
		position = Vector2(position.x - get_parent().SPEED * delta, position.y)
