extends Control


@onready var weapon_damage_multiplier:StatTextBox = $VFlowContainer/WeaponDamage
@onready var global_damage_multiplier:StatTextBox = $VFlowContainer/GlobalDamage
@onready var attack_speed_multiplier:StatTextBox = $VFlowContainer/AttackSpeed
@onready var crit_chance:StatTextBox = $VFlowContainer/CritChance
@onready var radius_multiplier:StatTextBox = $VFlowContainer/RadiusMultiplier
@onready var gold_multiplier:StatTextBox = $VFlowContainer/GoldMultiplier
@onready var move_speed_multiplier:StatTextBox = $VFlowContainer/MovementSpeed



func update_multipliers(weapon_damage:float, global_damage:float, attack_speed:float, critical_chance:float, radius:float, gold:float, movement_speed:float) -> void:
	weapon_damage_multiplier.update_multiplier(weapon_damage)
	global_damage_multiplier.update_multiplier(global_damage)
	attack_speed_multiplier.update_multiplier(attack_speed)
	crit_chance.update_multiplier(critical_chance)
	radius_multiplier.update_multiplier(radius)
	gold_multiplier.update_multiplier(gold)
	move_speed_multiplier.update_multiplier(movement_speed)
	
	
