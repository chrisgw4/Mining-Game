extends Node
class_name EffectComponent

@export_enum("Lightning", "Explosion") var effect_type:int


@export_range(0,1) var chance:float
@export var damage:float

@export var effect_scene:PackedScene

@export_range(0,1) var proc_itself_chance:float
@export_range(0,1) var max_proc_chance:float = 1

# The number of items had
var count:int = 1


func calculate_chance() -> float:
	return log(1+chance*count)
	return chance * count


func calculate_proc_self_chance() -> float:
	
	return clampf(log(1+proc_itself_chance*ceil(count*0.75)), 0, max_proc_chance)

# Explosion
# Lightning Chain React





