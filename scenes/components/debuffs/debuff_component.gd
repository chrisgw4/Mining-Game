extends Node
class_name DebuffComponent


@export var health_component:HealthComponent

var debuffs:Dictionary = {}


func compute_damage_multiplier() -> float:
	var total_multiplier:float = 1.0
	
	for debuff in debuffs:
		total_multiplier += debuffs[debuff].damage_multiplier * debuffs[debuff].stacks
	
	return total_multiplier

func compute_damage() -> float:
	var total_damage:float = 0.0
	
	for debuff in debuffs:
		total_damage += debuffs[debuff].damage# * debuffs[debuff].stacks
	
	return total_damage


func debuffs_changed() -> void:
	$Timer.start()
	


func _physics_process(delta):
	if len(debuffs) > 0:
		health_component.chip_damage(compute_damage()*delta)
		

func _on_timer_timeout():
	if len(debuffs) > 0:
		for debuff in debuffs:
			debuffs[debuff].stacks = clampf(debuffs[debuff].stacks-ceil(debuffs[debuff].stacks*0.05), 0, debuffs[debuff].stacks)
			#debuffs[debuff].stacks = clampf(debuffs[debuff].stacks, 0, debuffs[debuff].stacks)
			if debuffs[debuff].stacks == 0:
				debuffs.erase(debuff)
				get_parent().modulate = Color(1,1,1)
		if len(debuffs) > 0:
			$Timer.start()
		
		#print(compute_damage())
	
	
	pass
