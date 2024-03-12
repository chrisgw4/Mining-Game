extends Node2D


@onready var tile_map:TileMap = $TileMap

@onready var ore:PackedScene = preload("res://scenes/ores/stone.tscn")
@onready var rock_holder:Node2D = $Ores
@onready var shop_entrance:Node2D = $ShopEntrance

var shop:Shop

# Called when the node enters the scene tree for the first time.
func _ready():
	shop = load("res://scenes/shop/shop.tscn").instantiate()
	randomize()
	var dist_x:int = int(abs($Node2D.global_position.x) + abs($Node2D2.global_position.x))/16
	var dist_y:int = int(abs($Node2D.global_position.y) + abs($Node2D2.global_position.y))/16
	
	print(dist_x)
	var start_tile = tile_map.local_to_map(tile_map.to_local($Node2D2.global_position))
	var current_tile = start_tile
	
	for y in range(dist_y):
		
		
		for x in range(dist_x):
			#print(current_tile)
			
			if randi_range(0,100) < 30:
				if not tile_map.get_cell_tile_data(1, current_tile) and not tile_map.get_cell_tile_data(2, current_tile) and get_node("Player").global_position.distance_to(tile_map.to_global(tile_map.map_to_local(current_tile))) > 10:
					var temp = ore.instantiate()
					temp.global_position = tile_map.to_global(tile_map.map_to_local(current_tile))
					rock_holder.add_child(temp)
			
			current_tile.x += 1
		
		current_tile.y += 1 # increment each tile respectively
		current_tile.x = start_tile.x
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	pass
	

func _exit_shop(body) -> void:
	call_deferred("add_child", tile_map)
	call_deferred("add_child", rock_holder)
	call_deferred("add_child", shop_entrance)
	call_deferred("remove_child", shop)
	shop.disconnect("exit_shop", _exit_shop)
	body.global_position = get_node("SpawnPos").global_position
	shop_entrance.get_node("Area2D/CollisionShape2D").set_deferred("disabled", false) 
	


func _on_area_2d_body_entered(body):
	call_deferred("remove_child", rock_holder)
	call_deferred("remove_child", tile_map)
	call_deferred("remove_child", shop_entrance)
	shop_entrance.get_node("Area2D/CollisionShape2D").set_deferred("disabled", true) 
	call_deferred("add_child", shop)
	shop.connect("exit_shop", _exit_shop)
	body.global_position = shop.get_node("SpawnPos").global_position
