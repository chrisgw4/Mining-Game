extends Control


var used_slots:int = 0
var max_slots:int = 16

# dictionary to keep track of item name and its position
var dictionary:Dictionary = {}


# Updates count of items in inventory (when picking up multiple of same item)
func update_inventory(item:BuffItem, count:int) -> void:
	var slot:ItemSlot = $FlowContainer.get_child(dictionary[item.item_name])
	var texture:TextureRect = slot.get_node("ItemTexture")
	var label:RichTextLabel = slot.get_node("ItemCount")
	
	slot.count = count
	slot.description = item.description
	slot.item_name = item.item_name
	
	texture.texture = item.sprite.texture
	label.text = str(count)
	
	


# Add an item to the inventory, called by a signal from player (connected in UI Script)
func add_item(item:BuffItem, count:int) -> void:
	# Assign the name of the item in the dictionary to the next available index
	dictionary[item.item_name] = used_slots
	
	# get the available slot
	var slot:ItemSlot = $FlowContainer.get_child(dictionary[item.item_name])
	var texture:TextureRect = slot.get_node("ItemTexture")
	var label:RichTextLabel = slot.get_node("ItemCount")
	
	slot.count = count
	slot.description = item.description
	slot.item_name = item.item_name
	
	texture.texture = item.sprite.texture
	label.text = str(count)
	
	used_slots += 1
