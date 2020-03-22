extends Position2D

var Posi_Direito = Vector2()
var Posi_Esquerdo = Vector2()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			Posi_Esquerdo = event.position
			print("Left button was clicked at ",Posi_Esquerdo)
		if event.button_index == BUTTON_RIGHT and event.pressed:
			Posi_Direito = event.position
			print("Right button was clicked at ",Posi_Direito)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
