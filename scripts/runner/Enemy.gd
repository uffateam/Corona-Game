extends KinematicBody2D

export (int) var SPEED = 60
export (int) var GRAVITY = 800
var direction = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	direction.x = direction.x * SPEED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction.y += delta * GRAVITY
	
	if(not $RayCast2D.is_colliding() || not $RayCast2D2.is_colliding()):
		direction.x 
		direction.x = direction.x * -1
	
	if($RayCast2D3.is_colliding() || $RayCast2D4.is_colliding()):
		direction.x = direction.x * -1
	
	move_and_slide(direction, Vector2(0, 1))
