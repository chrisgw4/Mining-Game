extends Area2D
class_name Hitbox

@export var base_damage:float
@export var damage:float
@export var damage_multiplier:float = 1.0

func _ready():
	damage = base_damage

func _on_area_entered(area):
	if area is Hurtbox:
		print(damage * damage_multiplier)
		area.health_component.damage(damage * damage_multiplier)
	#pass
