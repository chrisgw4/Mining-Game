extends Area2D
class_name ShopInteractionComponent

signal interacted(body:Player)
signal player_entered(player:Player)
signal player_exited(player:Player)

var in_area:bool = false
var player:Player


func _on_body_entered(body:Player):
	in_area = true
	player = body
	emit_signal("player_entered", player)

func _on_body_exited(body:Player):
	in_area = false
	player = null
	emit_signal("player_exited", body)


func _input(event):
	if in_area and Input.is_action_just_pressed("interact"):
		emit_signal("interacted", player)
