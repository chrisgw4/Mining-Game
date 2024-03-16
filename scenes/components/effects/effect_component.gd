extends Node
class_name EffectComponent

@export_enum("Lightning", "Explosion") var effect_type:int


@export_range(0,1) var chance:float
@export var damage:float

@export var effect_scene:PackedScene

@export var proc_itself_chance:float

# The number of items had
var count:int = 1


func calculate_chance() -> float:
	return chance * count


# Explosion
# Lightning Chain React





