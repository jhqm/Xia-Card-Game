extends Node2D


#定义容器变量
var potential_damage 
var status = []
var SELECTEFFECT = null
signal beingAttacked


onready var HURTEFFECT = $EnemeyArea/hurtEffect
#onready var STATS = preload("res://Enemy/monster_db/monsterStats1.tscn")
#onready var stats = STATS.instance()

onready var lifebar = $lifebar
onready var damage_number = preload("res://UI/effects/damageNumber.tscn")



#初始化怪物数据导入
onready var db = preload("res://Enemy/monster_db/monsterDB.gd")

var monsterName = "mob"#默认名字
onready var MonsterImg = str("res://Enemy/ImgAssets/",monsterName,'.png')
onready var MonsterInfo = db.DataBase[monsterName]
onready var health = MonsterInfo[4]
onready var max_health = MonsterInfo[3]
onready var lifebar_distance = MonsterInfo[5]


#onready var LIFEBAR = preload("res://UI/lifeBar/lifebar.tscn")
#onready var lifebar = LIFEBAR.instance()

#初始化怪物与生命条
func _ready():
	#添加怪物sprite
	print(MonsterInfo)
	get_node("EnemeyArea/Sprite").texture = load(MonsterImg)
	
	#add_child(stats)

	
	#生命条数字初始化
	#lifebar.get_node("Label").text = str(stats.health)
	lifebar.get_node("Label").text = str(health)

	
	#生命条长度初始化
	lifebar.get_node('progress').scale.x = (float(health)/float(max_health))
	lifebar.get_node('progress under').scale.x = (float(health)/float(max_health))
	#生命条位置初始化
	lifebar.global_position = global_position+Vector2(0,-lifebar_distance)



func _process(delta):
	pass

#卡牌选中后透明化，并根据卡片种类生成选中效果
func _on_Area2D_area_entered(area):
	area.modulate = "61ffffff"
	if area.CardInfo['is_for_enemy']:
		selection()

	
#卡牌退出后去透明化，并去除选中效果
func _on_Area2D_area_exited(area):
	area.modulate = "ffffff"
	if area.CardInfo['is_for_enemy']:
		if SELECTEFFECT != null:
			print('unselected')
			unselection()

#产生选中效果
func selection():
	var selectEffect = load("res://UI/selectedeffect.tscn")
	SELECTEFFECT = selectEffect.instance()
	SELECTEFFECT.get_node('Sprite').texture = load("res://UI/select-removebg-preview.png")
	var world = get_tree().current_scene
	world.add_child(SELECTEFFECT)
	SELECTEFFECT.global_position = global_position + Vector2(10,100)
	
#去除选中效果	
func unselection():
	SELECTEFFECT.queue_free()



	
	

#确认受击信号
func _on_hurtEffect_animation_started(anim_name):
	if anim_name == "HurtEffect":
		var DAMAGE_NUMBER = damage_number.instance()
		get_node('..').add_child(DAMAGE_NUMBER)
		DAMAGE_NUMBER.global_position = global_position+Vector2(0,-lifebar_distance)
		DAMAGE_NUMBER.get_node('Label').text = str('-',potential_damage)
		DAMAGE_NUMBER.floatingEffect()
		
		health = health - potential_damage
		emit_signal("beingAttacked")
		
		potential_damage = 0
		#lifebar.get_node("Label").text = str(int(lifebar.get_node("Label").text) - 3 )

