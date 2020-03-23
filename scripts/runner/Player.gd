#tool
extends KinematicBody2D

export (int) var run_speed = 200
export (int) var jump_speed = -400
export (int) var gravity = 800

var velocity = Vector2()
var jumping = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass	
func _input(event):
	var Posi_Esquerdo = Vector2()
	var Posi_Direito = Vector2()
	var Posi_player = get("position")
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			Posi_Esquerdo = event.position
			var Posi_rel = Posi_Esquerdo-Posi_player
			var norma = sqrt((Posi_rel[0]*Posi_rel[0])+(Posi_rel[1]*Posi_rel[1]))
			print("A norma:",norma)
			print("Left button was direction uni ",Posi_rel/norma)
		if event.button_index == BUTTON_RIGHT and event.pressed:
			Posi_Direito = event.position
			var Posi_rel = Posi_Direito-Posi_player
			var norma = sqrt((Posi_rel[0]*Posi_rel[0])+(Posi_rel[1]*Posi_rel[1]))
			print("A norma:",norma)
			print("Right button was clicked at  uni ",Posi_rel/norma)
		
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
