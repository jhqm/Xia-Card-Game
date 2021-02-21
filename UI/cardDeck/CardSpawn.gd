extends Area2D


signal carddraw

onready var button = $TextureButton
var decksize = Vector2(130,130)


func _ready():
	button.rect_scale *= decksize/button.rect_size
#	button.get_node("Label").text = get_node('..').Decksize
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




