extends Node
#db variables: name,type,damage,qi_addon,is_for_enemy(bool),

#const DataBase = {
#	'fistAttack':
#		["fistAttack",'phy',3,0],
#	'chop':
#		["chop",'weapon',5,0],
#	'yunqi':
#		['yunqi','qi',0,3]
#
#
#
#
#
#}


const DataBase = {
	'fistAttack':
		{'name':"fistAttack",'type':'phy','damage':3,'qi_addone':0,'is_for_enemy':true},
	'chop':
		{'name':"chop",'type':'weaon','damage':5,'qi_addone':0,'is_for_enemy':true},
	'yunqi':
		{'name':"yunqi",'type':'qi','damage':0,'qi_addone':3,'is_for_enemy':false}
	
	
	
	
	
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
