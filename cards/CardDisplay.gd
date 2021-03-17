extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cardID = null
var cardName = null

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = load(str("res://cards/cardAssets/",cardName,'.png'))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
