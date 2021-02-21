extends Node2D


#定义容器变量
var potential_damage 
var status = []
var SELECTEFFECT = null
signal beingAttacked
signal beingboosted


onready var HURTEFFECT = $hurteffect


onready var lifebar = get_node('../panel/char_lifebar')
onready var forcebar = get_node('../panel/char_forcebar')
onready var damage_number = preload("res://UI/effects/damageNumber.tscn")



#初始化玩家数据导入
onready var db = $"/root/CharPanelDb"

#var monsterName = "mob"#默认名字
#onready var MonsterImg = str("res://Enemy/ImgAssets/",monsterName,'.png')
onready var playerInfo = db.playerDB
#onready var health = playerInfo[2]
#onready var max_health = playerInfo[1]
#onready var force = playerInfo[4]
#onready var max_force = playerInfo[3]





#初始化怪物与生命条
func _ready():
	print(playerInfo)
	
	#add_child(stats)

	
	#生命条数字初始化
	#lifebar.get_node("Label").text = str(stats.health)
	lifebar.get_node("Label").text = str(playerInfo[2])
	forcebar.get_node("Label").text = str(playerInfo[4])

	
	#生命条长度初始化
	lifebar.get_node('progress').scale.x = (float(playerInfo[2])/float(playerInfo[1]))
	lifebar.get_node('progress under').scale.x = (float(playerInfo[2])/float(playerInfo[1]))
	
	forcebar.get_node('progress').scale.x = (float(playerInfo[4])/float(playerInfo[3]))
	forcebar.get_node('progress under').scale.x = (float(playerInfo[4])/float(playerInfo[3]))


func _on_Area2D_area_entered(area):
	area.modulate = "61ffffff"
	if ! area.CardInfo['is_for_enemy']:
		selection()

	




func _on_Area2D_area_exited(area):
	area.modulate = "ffffff"
	if ! area.CardInfo['is_for_enemy']:
		if SELECTEFFECT != null:
			unselection()
		
		
		
#产生选中效果
func selection():
	var selectEffect = load("res://UI/selectedeffect.tscn")
	SELECTEFFECT = selectEffect.instance()
	SELECTEFFECT.get_node('Sprite').texture = load("res://UI/select_player.png")
	var world = get_tree().current_scene
	world.add_child(SELECTEFFECT)
	SELECTEFFECT.global_position = global_position + Vector2(10,80)
	
#去除选中效果	
func unselection():
	SELECTEFFECT.queue_free()
	
	
	

#
#
#
#
#
##确认受击信号
#func _on_hurtEffect_animation_started(anim_name):
#	if anim_name == "HurtEffect":
#		var DAMAGE_NUMBER = damage_number.instance()
#		get_node('..').add_child(DAMAGE_NUMBER)
#		DAMAGE_NUMBER.global_position = global_position+Vector2(0,-lifebar_distance)
#		DAMAGE_NUMBER.get_node('Label').text = str('-',potential_damage)
#		DAMAGE_NUMBER.floatingEffect()
#
#		health = health - potential_damage
#		emit_signal("beingAttacked")
#
#		potential_damage = 0
#		#lifebar.get_node("Label").text = str(int(lifebar.get_node("Label").text) - 3 )
#



