extends Area2D
class_name Hurtbox


@export var health_component:HealthComponent




# does nothing
func _on_area_entered(area):
	#health_component.damage(area.damage)
	pass
	
