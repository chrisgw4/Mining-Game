extends Node
class_name Debuff


@export_enum("Poison", "Fire") var debuff_type:int

@export var damage:float

## The amount of damage multiplier added per stack
## E.g. 0.15 * 10(stacks) = 1.5 damage multiplier
@export var damage_multiplier:float

## The time it takes to hit the enemy (if a damaging debuff)
@export var hit_time:float

## The number of stacks had on the debuff
@export var stacks:int = 1

## Insert Chance as a float between 0-1
@export_range(0,1) var chance:float = 0


func compute_debuff() -> float: 
	return 1.0

# Logarithmic Debuff chance computation
func calculate_chance() -> float:
	#print(1-(1/(1+chance * stacks)))
	return 1-(1/(1+chance * stacks))
	#return chance * stacks
