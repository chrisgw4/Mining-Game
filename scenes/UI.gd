extends CanvasLayer



@onready var label:RichTextLabel = $RichTextLabel
@export var player:Player

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("coin")
	player.connect("add_item_to_inventory", $Inventroy.add_item)
	player.connect("update_inventory", $Inventroy.update_inventory)
	player.connect("update_stat_ui", $GlobalStatsUI.update_multipliers)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	label.text = "       " + str(int(player.gold*10)*0.1)
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
	
	if "Moonshine" in player.item_dict:
		label.text += '\n'
		label.text += "Moonshine Chance: " + str(player.item_dict["Moonshine"][1].effects.calculate_chance()*100)
		label.text += '\n'
		label.text += "Moonshine Self Chance: " + str(player.item_dict["Moonshine"][1].effects.calculate_proc_self_chance()*100)
	
	


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		$Inventroy.visible = not $Inventroy.visible
		$GlobalStatsUI.visible = not $GlobalStatsUI.visible
