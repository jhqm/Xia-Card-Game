extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func floatingEffect():
	print(modulate)

	$Floating.interpolate_property(self,'position',position,position+Vector2(0,-40),1.2,Tween.TRANS_QUART,Tween.EASE_OUT)
	$Floating.interpolate_property(self,'modulate',modulate,Color8(1,1,1,0),1.2,Tween.TRANS_QUART,Tween.EASE_OUT)
	$Floating.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Floating_tween_all_completed():
	print('number queue_free')
	queue_free()
