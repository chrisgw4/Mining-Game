extends Area2D


@export var damage:float





func _on_area_entered(area):
	if area is Hurtbox:
		area.health_component.damage(damage)
	#pass
