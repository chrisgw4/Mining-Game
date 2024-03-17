extends Node2D
class_name BuffItem


@export var shop_component:ShopComponent

@export var stats_array:Array[StatComponent] = []

## Changes stat values such as damage multiplier or move speed
#@export var stats:StatComponent

## Causes on hit effects such as explosions or chain hits
@export var effects:EffectComponent

## Causes debuffs that can be applied on hit
@export var debuffs:Debuff

@export var item_name:String

@export var description:String

@onready var label:RichTextLabel = $ColorRect/ItemText
@onready var description_label:RichTextLabel = $ColorRect/Description
@onready var color_rect:ColorRect = $ColorRect

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var animation_player_ui:AnimationPlayer = $AnimationPlayerUI

@onready var sprite:Sprite2D = $Sprite2D



var count:int = 1:
	set(new_val):
		count = new_val
		effects.count = new_val

func _ready():
	animation_player.play("spawn")
	shop_component.shop_interactor.connect("player_entered", _show_item_stats)
	shop_component.shop_interactor.connect("player_exited", _hide_item_stats)
	


func _play_idle() -> void:
	animation_player.play("idle")


# Shows item stats when the player is in the shop_interaction's range (called by signal)
func _show_item_stats(player:Player) -> void:
	label.text = ""
	label.text += item_name
	label.text += "\n"
	label.text += "Price: " + str(shop_component.value)
	description_label.text = ""
	description_label.text += description
	
	#print(description_label.get_content_height())
	#print(label.get_content_height())
	
	# Dynamically changes the size of the color rect
	color_rect.size.y = label.get_line_count()*9.8 + description_label.get_line_count()*6.4 + 0.5
	animation_player_ui.play("show_ui")
	#label.visible = true



func _hide_item_stats(player:Player) -> void:
	animation_player_ui.play("hide_ui")
	#label.visible = false
	#$ColorRect.visible = false


