extends Node2D

#onready var inheritData = get_node("..").stats
var lefthealth = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("progress under").scale.y = 
	
	#get_node("Label").text = str(get_parent().stats.health)
	pass # Replace with function body.




func _on_Ennemy_beingAttacked():
	lefthealth = get_node("..").health
	get_node("Label").text = str(lefthealth)
	#print(lefthealth)
	#print(float(lefthealth)/float(get_node("..").stats.max_health))
	
	get_node("progress/ProgressTween").interpolate_property(get_node("progress"),'scale:x',get_node("progress").scale.x,float(lefthealth)/float(get_node("..").max_health),0.2,Tween.TRANS_QUART,Tween.EASE_OUT)
	get_node("progress/ProgressTween").start()
	
	get_node("progress under/UnderTween").interpolate_property(get_node("progress under"),'scale:x',get_node("progress under").scale.x,float(lefthealth)/float(get_node("..").max_health),1,Tween.TRANS_QUART,Tween.EASE_OUT,0.2)
	get_node("progress under/UnderTween").start()
	#get_node("Label").text = str(int(get_node("Label").text) - 3 )
	#print(inheritData.health)

