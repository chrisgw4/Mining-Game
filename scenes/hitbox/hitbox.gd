extends Area2D
class_name Hitbox

@export var base_damage:float
@export var damage:float
@export var damage_multiplier:float = 1.0
var critical_chance:float = 0.0

signal hit(pos, area)

var direction:Vector2

func _ready():
	damage = base_damage

func _on_area_entered(area):
	if area is Hurtbox:
		#print(damage * damage_multiplier)
		direction = global_position.direction_to(area.global_position)
		area.get_parent().direction = direction.normalized()
		
		emit_signal("hit", area.global_position, area)
		
		# Check if hit is a critical
		if  randf_range(0, 1) <= critical_chance:
			area.health_component.damage(damage * damage_multiplier*2) # Multiply damage by 2 for crit
		else:
			area.health_component.damage(damage * damage_multiplier)
		
	#pass
