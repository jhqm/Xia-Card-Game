extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var honver = $HoverAnimation
onready var CARDETURN = $cardReturn
onready var CARDDESPAWN = $cardDespawn
onready var originalPosition = global_position

var dragmouse = false
var activated = false

signal cardreturn



func _ready():
	print(get_parent())
	set_process(false)
	position = originalPosition
	



func _process(delta):
	if Input.is_action_just_released("MouseLeftButton"):
		print("sdsadda")
	if dragmouse == true:
		position = get_global_mouse_position()
		#print("pressed")
		
	else:
		if activated:
			honver.remove_all()
			CARDETURN.remove_all()

			CARDDESPAWN.interpolate_property(self,"position",global_position,get_node("../CardUsed").position, 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)
			CARDDESPAWN.interpolate_property(self,"scale",scale,Vector2(0,0), 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)
			CARDDESPAWN.start()
			print("fadong")
		else:

			emit_signal("cardreturn")
			#set_process(false)



func _on_Area2D_mouse_entered():
	if Input.is_action_pressed("MouseLeftButton"):
		pass
	else:
		honver.stop_all()
		honver.interpolate_property(self,"position",position,originalPosition + Vector2(0,-60), 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)
		honver.start()
		print("mouse enterd!")



func _on_Area2D_mouse_exited():
	honver.stop_all()
	honver.interpolate_property(self,"position",position,originalPosition, 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)
	honver.start()
	print("mouse left!")








func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			#honver.stop(honver)
			#honver.set_active(false)
			#get_parent().move_child(get_node("."),4)
			z_index = 1
			dragmouse = true
			set_process(true)
		else:
			dragmouse = false
			z_index = 0

			#print("released!")
			#honver.set_active(true)
			



func _on_Area2D_cardreturn():
	honver.stop_all()
	CARDETURN.interpolate_property(self,"position",global_position,originalPosition, 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)	

	CARDETURN.start()


func _on_Area2D_area_entered(area):
	if area.name == "EnemeyArea":
		activated = true

		






func _on_Area2D_area_exited(area):
	if area.name == "EnemeyArea":
		activated = false


func _on_cardDespawn_tween_all_completed():
	queue_free()
