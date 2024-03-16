extends Node2D
class_name ShopComponent

@export var value:float

@export_enum("Common", "Uncommon", "Rare", "Epic", "Legendary") var rarity:int



@export var shop_interactor:ShopInteractionComponent

# Signal that tells the pedestal that the item was bought
signal bought

# Called when the node enters the scene tree for the first time.
func _ready():
	if shop_interactor:
		shop_interactor.connect("interacted", _attempt_to_buy)


func _attempt_to_buy(body:Player) -> void:
	
	if body.gold >= value:
		body.gold -= value
		body.pick_up_item(get_parent())
		emit_signal("bought")
	
	
