extends CanvasLayer



@onready var label:RichTextLabel = $RichTextLabel
@export var player:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("coin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "       " + str(player.gold)
	label.text += "\n"
	label.text += "Damage Multiplier: " + str(player.damage_stat_multiplier)
	
	
	
	
