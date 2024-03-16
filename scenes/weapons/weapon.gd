extends Node2D


@export var hitbox:Hitbox
var effects:Dictionary = {}

# Stores the debuff effects and their enum value
var debuffs:Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox.connect("hit", _check_effects)



func attack() -> void:
	#$AnimationPlayer.speed_scale = 1
	$AnimationPlayer.play("swipe")


func update_damage(damage:float, damage_multiplier:float) -> void:
	hitbox.damage = hitbox.base_damage + damage
	hitbox.damage_multiplier = damage_multiplier


func update_crit_chance(crit_chance:float) -> void:
	hitbox.critical_chance = crit_chance


func _check_effects(pos:Vector2, area:Area2D) -> void:
	for effect in effects:
		var rand = randf_range(0, 1)
		if rand <= effects[effect].calculate_chance():
			var temp = effects[effect].effect_scene.instantiate()
			temp.global_position = pos
			get_tree().current_scene.call_deferred("add_child", temp)
			temp.proc_self_chance = effects[effect].proc_itself_chance
			
			if area not in temp.areas:
				temp.areas.append(area)
	
	for debuff in debuffs:
		var rand = randf_range(0, 1)
		if rand <= debuffs[debuff].calculate_chance():
			if debuff not in area.get_parent().debuff_component.debuffs:
				area.get_parent().debuff_component.debuffs[debuff] = debuffs[debuff].duplicate()
				area.get_parent().debuff_component.debuffs[debuff].stacks = 1
				area.get_parent().debuff_component.debuffs_changed()
			else:
				area.get_parent().debuff_component.debuffs[debuff].stacks += 1#debuffs[debuff].stacks
				
			if debuff == 1:
				area.get_parent().modulate = Color(0,1,0)
