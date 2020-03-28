extends KinematicBody2D

export (int) var run_speed = 400
export (int) var jump_speed = -400
export (int) var gravity = 800

var jumping = false
var hooking = false
var lowered = false
var rasteira = false
var shot = false

var velocity = Vector2()
var Posi_Esquerdo = Vector2()
var Posi_Direito = Vector2()
var Posi_rel = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _input(event):
	var norma
	if (event is InputEventMouseButton):
		var Posi_player = get("position")
		if (event.button_index == BUTTON_LEFT):
			if event.pressed:
				Posi_Esquerdo = event.position
				Posi_rel = Posi_Esquerdo - Posi_player
				norma = sqrt((Posi_rel[0] * Posi_rel[0]) + (Posi_rel[1] * Posi_rel[1]))
				Posi_rel = Posi_rel / norma
				shot = true
				$Gancho/CollisionShape2D/Sprite.show()
				if Posi_rel[0] > 0:
					$Gancho.rotation_degrees = -90 + atan((Posi_rel[1] / Posi_rel[0])) * 180 / PI
				else:
					$Gancho.rotation_degrees = 90 + atan((Posi_rel[1] / Posi_rel[0])) * 180 / PI
			else:
				hooking = false
				shot = false
				Posi_Direito = Vector2()
				Posi_Esquerdo = Vector2()

func _physics_process(delta):
	velocity.x = 0
	if shot == true:
		if len($Gancho.get_overlapping_bodies()) == 1:
			$Gancho/CollisionShape2D.scale.y += 1 #* delta
		else:
			shot = false
			hooking = true
		
	if (hooking == false):
		gravity = 800
		if shot == false:
			Posi_Direito = Vector2()
			Posi_Esquerdo = Vector2()
			if $Gancho/CollisionShape2D.scale.y > 1:
				$Gancho/CollisionShape2D.scale.y = $Gancho/CollisionShape2D.scale.y * 0.5
			else:
				$Gancho/CollisionShape2D/Sprite.hide()
	else:
		gravity = 0
		velocity.x = 800 * Posi_rel[0]
		velocity.y = 800 * Posi_rel[1]
		if $Gancho/CollisionShape2D.scale.y > 1:
			$Gancho/CollisionShape2D.scale.y -= 23.5 * delta 
		else:
			velocity.y = 0
			velocity.x = 0
			$Gancho/CollisionShape2D.scale.y = 1
			shot = false
	
	if (is_on_floor()):
		jumping = false
		if (Input.is_action_pressed("ui_up")) and (jumping == false):
			jumping = true
			velocity.y = jump_speed
		
	if (Input.is_action_pressed("ui_left")):
		$AnimatedSprite2.flip_h = true
		hooking = false
		velocity.x -= run_speed
		if (rasteira == false) and (lowered == false):
			$Collision.position.x = 1
			$Collision.position.y = 0.75
			$Collision.scale.x = 1
			$Collision.scale.y = 0.85
			$AnimatedSprite2.play("Run")
		if (Input.is_action_pressed("ui_down")):
			rasteira = true
			$Collision.position.x = 1
			$Collision.position.y = 11
			$Collision.scale.x = 1
			$Collision.scale.y = 0.4
			$AnimatedSprite2.play("Rasteira")
		elif (Input.is_action_just_released("ui_down")):
			rasteira = false
			$Collision.position.x = 1
			$Collision.position.y = 0.75
			$Collision.scale.x = 1
			$Collision.scale.y = 0.85
			$AnimatedSprite2.play("Run")
	elif (Input.is_action_pressed("ui_right")):
		$AnimatedSprite2.flip_h = false
		velocity.x += run_speed
		hooking = false
		if (rasteira == false) and (lowered == false):
			$Collision.position.x = 1
			$Collision.position.y = 0.75
			$Collision.scale.x = 1
			$Collision.scale.y = 0.85
			$AnimatedSprite2.play("Run")
		if (Input.is_action_pressed("ui_down")):
			rasteira = true
			$Collision.position.x = 1
			$Collision.position.y = 11
			$Collision.scale.x = 1
			$Collision.scale.y = 0.4
			$AnimatedSprite2.play("Rasteira")
		elif (Input.is_action_just_released("ui_down")):
			rasteira = false
			$Collision.position.x = 1
			$Collision.position.y = 0.75
			$Collision.scale.x = 1
			$Collision.scale.y = 0.85
			$AnimatedSprite2.play("Run")
	elif (Input.is_action_pressed("ui_down")):
		lowered = true
		rasteira = false
		$Collision.position.x = 1
		$Collision.position.y = 5
		$Collision.scale.x = 0.8
		$Collision.scale.y = 0.7
		$AnimatedSprite2.play("Abaixado")
	else:
		$Collision.scale.x = 0.6
		$Collision.scale.y = 1
		$Collision.position.x = 1
		$Collision.position.y = 1
		$AnimatedSprite2.play("Idle")
		rasteira = false
		lowered = false
	velocity.y += delta * gravity
	
	#if(not rasteira):
	velocity.x -= get_parent().get_node("Level").SPEED
	run_speed = 200 + get_parent().get_node("Level").SPEED

	velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_Area2D_area_entered(area):
	if(area.is_in_group("enemies")):
		get_tree().change_scene("res://scenes/ui/home.tscn")
