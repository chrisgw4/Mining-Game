extends CanvasLayer



@onready var label:RichTextLabel = $RichTextLabel
@export var player:Player

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("coin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	label.text = "       " + str(player.gold)
	label.text += "\n"
	label.text += "Damage: " + str(player.damage_stat_multiplier * (player.get_node("WoodSword").hitbox.damage))
	label.text += '\n'
	label.text += "Gold Multiplier: " + str(player.gold_stat_multiplier)
	label.text += '\n'
	label.text += "Crit Chance: " + str(player.critical_chance)
	label.text += '\n'
	label.text += "Rocks Remaining: " + str(get_parent().total_rocks)
	label.text += '\n'
	label.text += "Destroyed Rocks: " + str(get_parent().destroyed_rocks)
	label.text += '\n'
	label.text += "FPS: " + str(Engine.get_frames_per_second())
	
	
	
	
	
