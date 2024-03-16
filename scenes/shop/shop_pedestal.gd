extends Node2D
class_name ShopPedestal

static var available_common_items:Array[PackedScene] = [preload("res://scenes/items/apple.tscn"), preload("res://scenes/items/cheese.tscn"), preload("res://scenes/items/sardines.tscn"), preload("res://scenes/items/cookie.tscn")]

static var available_uncommon_items:Array[PackedScene] = [preload("res://scenes/items/red_pepper.tscn"), preload("res://scenes/items/onion.tscn")]

static var available_rare_items:Array[PackedScene] = [preload("res://scenes/items/moonshine.tscn")]

static var available_epic_items:Array[PackedScene] = []

static var available_legendary_items:Array[PackedScene] = []

static var all_common_items:Array[PackedScene] = [preload("res://scenes/items/apple.tscn"), preload("res://scenes/items/cheese.tscn"), preload("res://scenes/items/sardines.tscn"), preload("res://scenes/items/cookie.tscn")]
static var all_uncommon_items:Array[PackedScene] = [preload("res://scenes/items/red_pepper.tscn"), preload("res://scenes/items/onion.tscn")]
static var all_rare_items:Array[PackedScene] = [preload("res://scenes/items/moonshine.tscn")]

var is_empty = true

func pick_item() -> void:
	# Check if all available items are empty
	if len(available_common_items) == 0 and len(available_uncommon_items) == 0 and len(available_rare_items) == 0 and len(available_epic_items) == 0 and len(available_legendary_items) == 0:
		return 
	
	
	var rand_num = randi_range(0,100)
	
	
	if get_child_count() > 0:
		remove_child(get_child(0))
		is_empty = true
	
	# Common 40%
	if rand_num <= 40:
		#print(available_common_items)
		# Instantiate a random common that is not already in the shop
		print("Common")
		
		# Check if available common items are empty
		if len(available_common_items) == 0:
			print("no more common")
			pick_item()
			return
		
		
		var item:PackedScene = available_common_items.pick_random()
		available_common_items.remove_at(available_common_items.find(item))
		
		if item:
			var child:BuffItem = item.instantiate()
			add_child(child)
			child.position.y = -5
			is_empty = false
			child.shop_component.connect("bought", _set_empty)
			
		pass
	# Uncommon 30%
	elif rand_num <= 70:
		print("Uncommon")
		
		# Instantiate a random uncommon that is not already in the shop
		
		# Check if available uncommon items are empty
		if len(available_uncommon_items) == 0:
			print("no more uncommon")
			pick_item()
			return
		
		
		var item:PackedScene = available_uncommon_items.pick_random()
		available_uncommon_items.remove_at(available_uncommon_items.find(item))
		
		if item:
			var child:BuffItem = item.instantiate()
			add_child(child)
			child.position.y = -5
			is_empty = false
			child.shop_component.connect("bought", _set_empty)
			
		pass
	# Rare 15%
	elif rand_num <= 85:
		print("Rare")
		
		# Check if available rare items are empty
		if len(available_rare_items) == 0:
			print("no more rare")
			pick_item()
			return
		
		# Instantiate a random rare that is not already in the shop
		var item:PackedScene = available_rare_items.pick_random()
		available_rare_items.remove_at(available_rare_items.find(item))
		
		if item:
			var child:BuffItem = item.instantiate()
			add_child(child)
			child.position.y = -5
			is_empty = false
			child.shop_component.connect("bought", _set_empty)
		pass
	# Epic 10%
	elif rand_num <= 95:
		print("Epic")
		
		# Check if available epic items are empty
		if len(available_epic_items) == 0:
			print("no more epic")
			pick_item()
			return
		pass
	# Legendary 5%
	elif rand_num <= 100:
		print("Legendary")
		
		# Check if available epic items are empty
		if len(available_legendary_items) == 0:
			print("no more legendary")
			pick_item()
			return
		pass


func _set_empty() -> void:
	is_empty = true


static func reset_item_availability() -> void:
	#available_common_items.clear()
	#for item in all_common_items:
	#	available_common_items.append(item)
	available_common_items = all_common_items.duplicate()
	available_uncommon_items = all_uncommon_items.duplicate()
	available_rare_items = all_rare_items.duplicate()
	#available_common_items = all_common_items
	#available_uncommon_items = all_uncommon_items
	
