extends KinematicBody2D

export (int) var run_speed = 200
export (int) var jump_speed = -400
export (int) var gravity = 800

var velocity = Vector2()
var jumping = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	velocity.x = 0
	
	if Input.is_action_pressed("ui_up") and (jumping == false):
		jumping = true
		velocity.y = jump_speed
	
	if is_on_floor():
		jumping = false
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= run_speed
		$Sprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		velocity.x += run_speed
		$Sprite.flip_h = false
	
	velocity.y += delta * gravity
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
