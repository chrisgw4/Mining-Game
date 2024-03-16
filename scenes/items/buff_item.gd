extends Node2D
class_name BuffItem


@export var shop_component:ShopComponent

## Changes stat values such as damage multiplier or move speed
@export var stats:StatComponent

## Causes on hit effects such as explosions or chain hits
@export var effects:EffectComponent

## Causes debuffs that can be applied on hit
@export var debuffs:Debuff

@export var item_name:String

@export var description:String

@onready var label:RichTextLabel = $ColorRect/ItemText



var count:int = 1

func _ready():
	$AnimationPlayer.play("spawn")
	shop_component.shop_interactor.connect("player_entered", _show_item_stats)
	shop_component.shop_interactor.connect("player_exited", _hide_item_stats)
	


func _play_idle() -> void:
	$AnimationPlayer.play("idle")



func _show_item_stats(player:Player) -> void:
	label.text = ""
	label.text += item_name
	label.text += "\n"
	label.text += "Price: " + str(shop_component.value)
	$ColorRect/Description.text = ""
	$ColorRect/Description.text += description
	$AnimationPlayerUI.play("show_ui")
	#label.visible = true



func _hide_item_stats(player:Player) -> void:
	$AnimationPlayerUI.play("hide_ui")
	#label.visible = false
	#$ColorRect.visible = false


