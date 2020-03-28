extends Node2D

export (PackedScene) var initialBlock 
export (String) var blocksPath

onready var currentBlock = initialBlock.instance()
var nextBlock = null
var preparedBlock = null

var SPEED = 100

func getRandomBlock():
	var files = []
	var dir = Directory.new()
	dir.open(blocksPath)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file == "InitialLevelBlock.tscn":
			continue
		elif not file.begins_with("."):
			files.append(file)
	
	dir.list_dir_end()
	
	return load(blocksPath+'/'+files[randi() % files.size()]).instance()

func _ready():
	add_child(currentBlock)
	randomize()
	
	nextBlock = getRandomBlock()
	nextBlock.position = Vector2(currentBlock.position.x + 1280, 0)
	add_child(nextBlock)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(preparedBlock == null):
		preparedBlock = getRandomBlock()
		preparedBlock.position = Vector2(1280, 0)
		add_child(preparedBlock)
		preparedBlock.position = Vector2(1280 + nextBlock.position.x, 0)
	
	if(currentBlock.position.x < -1280):
		currentBlock = nextBlock
		nextBlock = preparedBlock
		preparedBlock = null


func _on_Timer_timeout():
		SPEED += (2000 / SPEED) + 5
