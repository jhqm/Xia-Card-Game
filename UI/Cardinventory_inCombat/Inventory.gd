extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var CARDDISPLAY = preload("res://cards/CardDisplay.tscn")

#查剩余牌组使用此赋值语句
#onready var playerDeck = get_tree().current_scene.playerdeck
#查全部牌组使用此赋值语句
onready var playerDeck = $"/root/PlayerDeck".duplicate()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in playerDeck.CardList:
		var showCard = CARDDISPLAY.instance()
		showCard.cardID = i
		showCard.cardName = playerDeck.PlayerCardDB[i]["name"]
		get_node("MarginContainer/vbox/ScrollContainer/MarginContainer/GridContainer").add_child(showCard)
		print(i)
		print(playerDeck.PlayerCardDB[i]["name"])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().current_scene.inventoryOpen = false
	queue_free()
