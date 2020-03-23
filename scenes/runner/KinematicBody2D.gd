extends KinematicBody2D
''
export (int) var run_speed = 200
export (int) var jump_speed = -400
export (int) var gravity = 800

var velocity = Vector2()
var jumping = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
''
