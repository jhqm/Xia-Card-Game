extends Area2D


onready var honver = $HoverAnimation
onready var CARDETURN = $cardReturn
onready var CARDDESPAWN = $cardDespawn
onready var CARDSPAWN = $cardSpawn
onready var CARDMOVING = $cardMoving
var cardSize = Vector2(280,400)
var originalPosition 
var cardForEnemy = ['phy','weapon']
var cardForPlayer = ['qi','heal']
var originalZ 
var dragable = false

#卡牌数据初始化导入
onready var db = preload("res://cards/cardsDB.gd")

var cardName = "fistAttack"#默认名字
onready var CardImg = str("res://cards/cardAssets/",cardName,'.png')
onready var CardInfo = db.DataBase[cardName]
onready var damage = CardInfo['damage']


#局内逻辑开关
var dragmouse = false
var activated = false
var underAttack = null
var selfUnit = null

var honver_active = false
var CARDETURN_active = false


signal cardreturn


var position_delta = Vector2.ZERO

#卡牌牌面及数据显示初始化
func _ready():
	#honver.set_active(false)
	#CARDETURN.set_active(false)
	$"card-border_selected".visible = false
	set_process(false)
	
	#设定卡片,碰撞区域，以及边框初始化大小
	get_node("sprite").texture = load(CardImg)
	get_node("sprite").scale *= cardSize/get_node("sprite").texture.get_size()
	get_node("CollisionShape2D").scale *= cardSize/get_node("CollisionShape2D").get_shape().extents*Vector2(0.5,0.5)
	get_node("card-border_selected").scale *= cardSize/get_node("card-border_selected").texture.get_size()
	
	#yield(get_tree().create_timer(0.01),"timeout")
	#var originalPosition = position
	card_spawn_animation(originalPosition)
	print('originalZ',originalZ)


	#position = originalPosition
	
	#print(CardInfo)
	
	



func _process(delta):
	
	

	
	if dragmouse == true :
		#增加被选择边框
		$"card-border_selected".visible = true
		#拖拽跟随
		position = get_global_mouse_position()+position_delta

		
	else:
		position_delta = Vector2.ZERO
		
		if activated:  #卡牌正式触发


			
			#手牌数组删除以及墓地数组增加	
			var delete_index_ins = get_node('../..').inhands_cardinstance.find(get_node("."))
			get_node('../..').inhands_cardinstance.remove(delete_index_ins)
			var delete_index = get_node('../..').inhands.find(cardName)
			
			get_node('../..').graveyard.append(get_node('../..').inhands[delete_index_ins])
			get_node('../..').inhands.remove(delete_index)
			
			get_node('../..').number_inhands = get_node('../..').inhands.size()
			
			
			#墓地数字刷新
			get_node('../../CardUsed/Label').text = str( get_node('../..').graveyard.size())
			
			#手牌位置重新排列
			get_node('../..').card_position_resort(get_node('../..').number_inhands)
			
			
			#卡牌进入墓地动画效果
			$CollisionShape2D.disabled = true
			CARDDESPAWN.interpolate_property(self,"position",position,get_node("../../CardUsed").position, 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)
			CARDDESPAWN.interpolate_property(self,"scale",scale,Vector2(0,0), 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)
			CARDDESPAWN.start()
					
			#卡牌数值生效
			match CardInfo['type']:
				"phy":
					underAttack.get_node('..').potential_damage = damage
					underAttack.get_node('hurtEffect').play("HurtEffect")
					underAttack.get_node("..").unselection()
					
				'qi':
					print("qi!")
			
			
			#终止遍历
			set_process(false)


				
				
				
		else:
			$"card-border_selected".visible = false
			emit_signal("cardreturn")
			#print('cardreturn')
			#print(CARDETURN.is_active())
			set_process(false)

func CardeEffectExcute():
	pass
	


#检测卡牌上的点击事件
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		
		if event.is_pressed():
			if dragable:
				honver.remove_all()
				CARDETURN.remove_all()


				#z_index = get_node('../..').inhands_cardinstance.size()+1
				z_index =1
				position_delta = position-get_global_mouse_position()
				dragmouse = true
				set_process(true)
		else:
			dragmouse = false
			#z_index = originalZ
			z_index = 0


			


#鼠标hover进入
func _on_Area2D_mouse_entered():
	if Input.is_action_pressed("MouseLeftButton"):
		pass
	else:
		if honver_active :
			
			print ("order",originalZ)
			get_tree().current_scene.hover.append(self.originalZ)

			#防鼠标穿透过滤
			for i in get_tree().current_scene.inhands_cardinstance:
				if get_tree().current_scene.hover.has(i.originalZ):
					if i.originalZ == get_tree().current_scene.hover.max():
						print(get_tree().current_scene.hover)
						i.z_index = 1
						i.cardhoverAnimation()
						i.dragable = true
						
					else:
						i.z_index = 0
						i.cardUnhoverAnimation()
						i.dragable = false

			
#鼠标hover退出
func _on_Area2D_mouse_exited():

	if honver_active:
		
		var index = get_tree().current_scene.hover.find(self.originalZ)
		get_tree().current_scene.hover.remove(index)
		#print(get_tree().current_scene.hover)
		
		#防鼠标穿透过滤
		if get_tree().current_scene.hover == []:
			z_index = 0
			cardUnhoverAnimation()
		for i in get_tree().current_scene.inhands_cardinstance:
				if get_tree().current_scene.hover.has(i.originalZ):
					if i.originalZ == get_tree().current_scene.hover.max():
						print(get_tree().current_scene.hover)
						i.z_index = 1
						i.cardhoverAnimation()
						i.dragable = true
						
					else:
						i.z_index = 0
						i.cardUnhoverAnimation()
						i.dragable = false
				else:
					i.z_index = 0
					i.cardUnhoverAnimation()
					i.dragable = false

		
#hover升起效果
func cardhoverAnimation():
	CARDETURN.remove_all()
	honver.remove_all()
	honver.interpolate_property(self,"position",position,originalPosition + Vector2(0,-60), 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)
	honver.start()


#hover退出效果
func cardUnhoverAnimation():		
	CARDETURN.remove_all()
	honver.remove_all()
	honver.interpolate_property(self,"position",position,originalPosition, 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)
	honver.start()




#卡片生成动画效果
func card_spawn_animation(_position):

	CARDSPAWN.interpolate_property(self,"position",get_node("../../CardSpawn").position,_position, 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)
	CARDSPAWN.interpolate_property(self,"scale",Vector2(0,0),Vector2(0.5,0.5), 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)
	CARDSPAWN.start()

#卡牌移动效果
func card_moving_animation(start,end):
	CARDMOVING.interpolate_property(self,"position",start,end, 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)
	CARDMOVING.start()





#卡牌回弹效果
func _on_Area2D_cardreturn():
	if CARDETURN_active:
		honver.remove_all()
		CARDETURN.interpolate_property(self,"position",position,originalPosition, 0.7,Tween.TRANS_QUINT,Tween.EASE_OUT)	

		CARDETURN.start()
			
		
		
	

#检测卡牌是否进入怪物受击区域、检测卡牌是否进入玩家触发区域
func _on_Area2D_area_entered(area):
	if area.name == "EnemeyArea":
		if CardInfo['is_for_enemy'] :
			activated = true
			underAttack = area
			#print(underAttack)
		
	elif area.name == "charArea":
		if ! CardInfo['is_for_enemy'] :
			activated = true
			selfUnit = area
			print("it's for char")
		


func _on_Area2D_area_exited(area):
	if area.name == "EnemeyArea":
		if  CardInfo['is_for_enemy'] :
			activated = false
			underAttack = null
			#print(underAttack)

		
	elif area.name == "charArea":
		if  ! CardInfo['is_for_enemy']:
			activated = false
			selfUnit = null
			print("it's for char")

		
		


		

#卡片清除
func _on_cardDespawn_tween_all_completed():
#	var delete_index_ins = get_node('../..').inhands_cardinstance.find(get_node("."))
#	get_node('../..').inhands_cardinstance.remove(delete_index_ins)
#	var delete_index = get_node('../..').inhands.find(cardName)
#
#	get_node('../..').graveyard.append(get_node('../..').inhands[delete_index_ins])
#	get_node('../..').inhands.remove(delete_index)
#
#	get_node('../../CardUsed/Label').text = str( get_node('../..').graveyard.size())
#
	
	
	queue_free()




#卡片生成动画完成
func _on_cardSpawn_tween_all_completed():
	#print('spawn completed')
	honver_active = true
	CARDETURN_active = true
	#CARDETURN.set_active(true)
	#honver.set_active(true)


