extends Node2D

# 初始化变量
onready var CardBase =  preload("res://cards/cardBase.tscn")
onready var PLAYERDECK = $"/root/PlayerDeck"
onready var playerdeck = PLAYERDECK.duplicate()
var inhands = []
var inhands_cardinstance = []
var graveyard = []
var hover = [] setget hoverSet
var number_inhands = 0


var index_cardWillSpawn = []
onready var Decksize = playerdeck.CardList.size()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	get_node("CardSpawn/TextureButton/Label").text = str(Decksize)
	pass # Replace with function body.




func _on_TextureButton_pressed():

	var count = 1
	var number_of_spawn = get_node("/root/CharPanelDb").playerDB[5]-inhands_cardinstance.size()
	card_spwan_muti(count,number_of_spawn)

#抽取多张卡牌
func card_spwan_muti(count,_number_of_spawn):

	if count <= _number_of_spawn:

		cardSpawn()
		#刷新牌组数量显示
		get_node("CardSpawn/TextureButton/Label").text = str(Decksize)
		
		yield(get_tree().create_timer(0.2),"timeout")
		count +=1
		card_spwan_muti(count,_number_of_spawn)
		
	else:
		print('hands full again!')
		


#随机生成抽取卡牌(不放回式抽取)	
func cardSpawn():
	Decksize = playerdeck.CardList.size()
	if Decksize > 0 :
		if inhands_cardinstance.size()< get_node("/root/CharPanelDb").playerDB[5]:
			var new_card = CardBase.instance()
			inhands_cardinstance.append(new_card)

			#随机抽取牌组中的一张，并将这张送往手牌
			index_cardWillSpawn = randi()%Decksize
			inhands.append(playerdeck.CardList[index_cardWillSpawn])
			new_card.cardName = playerdeck.PlayerCardDB[playerdeck.CardList[index_cardWillSpawn]]['name']
			new_card.cardID = playerdeck.CardList[index_cardWillSpawn]
			
			
			#new_card.z_index = inhands_cardinstance.size()
			#new_card.originalZ = new_card.z_index

			
			number_inhands = inhands.size()
			
			#分配卡牌生成位置
			card_position_sort(number_inhands)
			

				

			
			#从牌库中去除这一张
			playerdeck.CardList.remove(index_cardWillSpawn)
			Decksize = playerdeck.CardList.size()
			
			$cards.add_child(new_card)
			
		else:
			print('hands full!')
		
	else: 
		print('no card!')
		
		
		
#分配卡牌生成位置
func card_position_sort(_number_inhands):
		var count = 1
		for i in inhands_cardinstance:
			i.originalZ = count
			if count<_number_inhands:
				
				#i.CARDSPAWN.seek(0.7)
				#i.CARDSPAWN.remove_all()
				#print(i.CARDSPAWN.tell())
#				i.CARDSPAWN.remove_all()
				
				i.card_moving_animation(i.position,get_node("position1").position + Vector2((_number_inhands-1)*(-40),0) + Vector2((count-1)*80,0))
				i.originalPosition = get_node("position1").position + Vector2((_number_inhands-1)*(-40),0) + Vector2((count-1)*80,0)
				
			else:
			
				
				#i.position = get_node("position1").position + Vector2((_number_inhands-1)*(-40),0) + Vector2((count-1)*80,0)
				i.position = get_node("CardSpawn").position
				i.scale = Vector2(0,0)
				#print('positionchanged')
				i.originalPosition = get_node("position1").position + Vector2((_number_inhands-1)*(-40),0) + Vector2((count-1)*80,0)
				print('origipositionchanged')
			
			count += 1
	
#卡牌位置重新排序
func card_position_resort(_number_inhands):
		var count = 1
		for i in inhands_cardinstance:
			i.originalZ = count
			i.card_moving_animation(i.position,get_node("position1").position + Vector2((_number_inhands-1)*(-40),0) + Vector2((count-1)*80,0))

			#i.position = get_node("position1").position + Vector2((_number_inhands-1)*(-40),0) + Vector2((count-1)*80,0)
			i.originalPosition = get_node("position1").position + Vector2((_number_inhands-1)*(-40),0) + Vector2((count-1)*80,0)
			
			count += 1
		
func hoverSet(new_value):
	hover=new_value
	print("hoverSet")
	
