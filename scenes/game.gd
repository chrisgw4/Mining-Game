extends Node2D


@onready var tile_map:TileMap = $SceneHolder1/TileMap

@onready var ore:PackedScene = preload("res://scenes/ores/stone.tscn")
@onready var shop_entrance:Node2D = $ShopEntrance

@onready var scene_holder1:Node = $SceneHolder1


var difficulty_scale:float = 1
signal update_difficulty(new_difficulty_scale)

var destroyed_rocks:int = 0:
	set(new_val):
		if new_val == 0:
			spawn_ores()
			difficulty_scale *= 1.15
			emit_signal("update_difficulty", difficulty_scale)
		
		destroyed_rocks = new_val


var total_rocks:int = 0:
	set(new_val):
		
		
		if new_val < total_rocks:
			destroyed_rocks+=1
		
		total_rocks = new_val
			

var shop:Shop

# Called when the node enters the scene tree for the first time.
func _ready():
	shop = load("res://scenes/shop/shop.tscn").instantiate()
	randomize()
	
	spawn_ores()


func spawn_ores() -> void:
	var dist_x:int = int(int(abs($Node2D.global_position.x) + abs($Node2D2.global_position.x))/16)
	var dist_y:int = int(int(abs($Node2D.global_position.y) + abs($Node2D2.global_position.y))/16)
	
	
	var start_tile = tile_map.local_to_map(tile_map.to_local($Node2D2.global_position))
	var current_tile = start_tile
	
	for y in range(dist_y):
		for x in range(dist_x):
			#print(current_tile)
			
			if randi_range(0,100) < 30:
				if not tile_map.get_cell_tile_data(1, current_tile) and not tile_map.get_cell_tile_data(2, current_tile) and get_node("SceneHolder1/Player").global_position.distance_to(tile_map.to_global(tile_map.map_to_local(current_tile))) > 10:
					var temp = ore.instantiate()
					temp.global_position = tile_map.to_global(tile_map.map_to_local(current_tile))
					scene_holder1.add_child(temp)
					total_rocks+=1
					temp.connect("destroyed", _decrement_total_rocks)
					connect("update_difficulty", temp._change_difficulty)
			
			current_tile.x += 1
		
		current_tile.y += 1 # increment each tile respectively
		current_tile.x = start_tile.x



func _decrement_total_rocks():
	total_rocks -= 1



func _on_area_2d_area_entered(area):
	pass
	

func _exit_shop(body) -> void:
	body.reparent(scene_holder1)
	call_deferred("add_child", scene_holder1)
	call_deferred("remove_child", shop)
	shop.disconnect("exit_shop", _exit_shop)
	body.global_position = get_node("SpawnPos").global_position
	shop_entrance.get_node("Area2D/CollisionShape2D").set_deferred("disabled", false) 
	


func _on_area_2d_body_entered(body):
	body.reparent(shop)
	call_deferred("remove_child", scene_holder1)
	shop_entrance.get_node("Area2D/CollisionShape2D").set_deferred("disabled", true) 
	call_deferred("add_child", shop)
	shop.connect("exit_shop", _exit_shop)
	body.global_position = shop.get_node("SpawnPos").global_position
