extends Node2D

#玩家装配牌库
var CardList = [
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13

]


#玩家剩余牌库
var CardInventory = [
	14,
	15
	
	
	
]

#玩家卡牌数据库
#原理：利用自增ID做key，一个包含若干字段的dictionary作为value，记录卡牌的名字（名字会用在CardsDB里做基础数值的索引），护主属性词条，以及当前熟练度（或其他更多属性）
var PlayerCardDB = {
	1:{'name':'fistAttack'},
	2:{'name':'fistAttack'},
	3:{'name':'fistAttack'},
	4:{'name':'fistAttack'},
	5:{'name':'fistAttack'},
	6:{'name':'fistAttack'},
	7:{'name':'yunqi'},
	8:{'name':'yunqi'},
	9:{'name':'yunqi'},
	10:{'name':'yunqi'},
	11:{'name':'yunqi'},
	12:{'name':'yunqi'},
	13:{'name':'yunqi'},
	14:{'name':'yunqi'},
	15:{'name':'yunqi'}
	
	
	
	
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
