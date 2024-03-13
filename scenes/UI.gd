extends CanvasLayer



@onready var label:RichTextLabel = $RichTextLabel
@export var player:Player

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("coin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "       " + str(player.gold)
	label.text += "\n"
	label.text += "Damage: " + str(player.damage_stat_multiplier * (player.get_node("WoodSword").hitbox.damage))
	
	
	
	
