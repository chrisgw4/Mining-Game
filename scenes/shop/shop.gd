extends Node2D
class_name Shop

signal exit_shop(body)



signal refresh_shop()
var cost_to_refresh:float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("crab")
	$ShopInteractionComponent.connect("interacted", _refresh_shop)
	
	#connect("refresh_shop", $ShopPedestal1.pick_item)
	#connect("refresh_shop", $ShopPedestal2.pick_item)
	#connect("refresh_shop", $ShopPedestal3.pick_item)
	#connect("refresh_shop", $ShopPedestal4.pick_item)
	#connect("refresh_shop", $ShopPedestal5.pick_item)
	#
	#emit_signal("refresh_shop")
	refresh_shops()

func refresh_shops() -> void:
	$ShopPedestal1.pick_item()
	await get_tree().create_timer(0.05).timeout
	$ShopPedestal2.pick_item()
	await get_tree().create_timer(0.05).timeout
	$ShopPedestal3.pick_item()
	await get_tree().create_timer(0.05).timeout
	$ShopPedestal4.pick_item()
	await get_tree().create_timer(0.05).timeout
	$ShopPedestal5.pick_item()

func _on_area_2d_body_entered(body):
	emit_signal("exit_shop", body)


func _refresh_shop(body:Player):
	if body.gold >= cost_to_refresh:
		ShopPedestal.reset_item_availability()
		emit_signal("refresh_shop")
		refresh_shops()
	
