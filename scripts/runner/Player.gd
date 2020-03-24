#tool
extends KinematicBody2D

export (int) var run_speed = 200
export (int) var jump_speed = -400
export (int) var gravity = 800

var velocity = Vector2()
var jumping = false
var hooking = false
var Posi_Esquerdo = Vector2()
var Posi_Direito = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass	
func _input(event):
	var Posi_rel = Vector2()
	var norma
	if event is InputEventMouseButton:
		var Posi_player = get("position")
		if event.button_index == BUTTON_LEFT and event.pressed:
			Posi_Esquerdo = event.position
			Posi_rel = Posi_Esquerdo - Posi_player
			norma = sqrt((Posi_rel[0] * Posi_rel[0]) + (Posi_rel[1] * Posi_rel[1]))
			if (norma > 50) and (norma < 400):
				velocity.x = 500 * Posi_rel[0]/norma
				velocity.y = 500 * Posi_rel[1]/norma
				hooking = true
						
		if event.button_index == BUTTON_RIGHT and event.pressed:
			Posi_Direito = event.position
			Posi_rel = Posi_Direito - Posi_player
			norma = sqrt((Posi_rel[0] * Posi_rel[0]) + (Posi_rel[1] * Posi_rel[1]))
			if (norma > 50) and (norma < 400):
				velocity.x = 500 * Posi_rel[0]/norma
				velocity.y = 500 * Posi_rel[1]/norma
				hooking = true
	else:
		hooking = false
		Posi_Direito = Vector2()
		Posi_Esquerdo = Vector2()
func _physics_process(delta):
	if (hooking == false):
		gravity = 800
		velocity.x = 0 
	else:
		gravity = 0
	var Posi_player = get("position")
	var Posi_rel_D = Posi_Direito - Posi_player
	var Posi_rel_E = Posi_Esquerdo - Posi_player
	var norma_D = sqrt((Posi_rel_D[0] * Posi_rel_D[0]) + (Posi_rel_D[1] * Posi_rel_D[1]))
	var norma_E = sqrt((Posi_rel_E[0] * Posi_rel_E[0]) + (Posi_rel_E[1] * Posi_rel_E[1]))
	if(norma_D < 50) or (norma_E < 50):
#		hooking = false
		velocity.y = 0
		velocity.x = 0
		Posi_Direito = Vector2()
		Posi_Esquerdo = Vector2()
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
