extends Area2D
class_name ShopInteractionComponent

signal interacted(body:Player)


var in_area:bool = false
var player:Player


func _on_body_entered(body:Player):
	
	in_area = true
	player = body

func _on_body_exited(body:Player):
	in_area = false
	player = null


func _input(event):
	if in_area and player and Input.is_action_just_pressed("interact"):
		emit_signal("interacted", player)
