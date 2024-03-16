extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var velocity_component = $VelocityComponent

var is_on_floor = true
var jump_pos: float = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var damage_stat_multiplier:float = 1.0
var damage_stat_added:int = 0

var attack_speed_stat_multiplier:float = 1.0

var gold_stat_multiplier:float = 1.0

var move_speed_stat_multiplier:float = 1.0

var radius_size_stat_multiplier:float = 1.0

var critical_chance:float = 0.0

# Dictionary will keep track the number of each specific item you have
var item_dict:Dictionary


var gold:float = 40.0

@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D


func get_input():
	var dir:Vector2 = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),  Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	
	#var past_velocity = velocity_component.Velocity
	
	velocity_component.accelerate_in_direction(dir)
	
	
	if Input.is_action_pressed("attack"):
		if not $WoodSword/AnimationPlayer.is_playing():
			$WoodSword.look_at(get_global_mouse_position())
		$WoodSword.attack()
	
	
	#
	#if Input.is_action_just_pressed("jump") and is_on_floor:
		#is_on_floor = false
		#jump_pos = global_position.y
		#velocity_component.Velocity.y = -100
	#elif not is_on_floor:
		#velocity_component.Velocity.y = past_velocity.y + 4
		#print(velocity_component.Velocity.y)
	#
		#if global_position.y >= jump_pos:
			#is_on_floor = true
			#velocity_component.Velocity.y = 0
			
		
	
	velocity_component.move(self)
	
	

func pick_up_item(item) -> void:
	#print(item)
	
	# If the item has a stat buff
	if item.stats:
		print(item.stats.stat_type)
		
		if item.item_name in item_dict:
			item_dict[item.item_name][0] += 1
		else:
			item_dict[item.item_name] = [1, item.stats.duplicate()]
		
		print(item_dict)
		
		match item.stats.stat_type:
			0: # Move Speed
				
				#move_speed_stat_multiplier *= item.stats.multiplier
				
				#for items in item_dict:
				move_speed_stat_multiplier += item_dict[item.item_name][1].multiplier
				
				velocity_component.speed_multiplier = move_speed_stat_multiplier
				
			1: # Attack Damage
				damage_stat_added += item_dict[item.item_name][1].added
				damage_stat_multiplier += item_dict[item.item_name][1].multiplier
				$WoodSword.update_damage(damage_stat_added, damage_stat_multiplier)
				
				
			2: # Attack Speed
				pass
				
			3: # Gold Multiplier
				gold_stat_multiplier += item_dict[item.item_name][1].multiplier
				
				
			4: # Radius Size
				radius_size_stat_multiplier += item_dict[item.item_name][1].multiplier
				# Cap the size multiplier at 6-8
				radius_size_stat_multiplier = clampf(radius_size_stat_multiplier, 1, 8)
				$WoodSword.scale = Vector2.ONE * radius_size_stat_multiplier
			5: # Critical Chance
				critical_chance += item_dict[item.item_name][1].multiplier
				$WoodSword.update_crit_chance(critical_chance)
				
	if item.effects:
		# Check if the effect_type (Enum) is in the wood sword already
		if item.effects.effect_type not in $WoodSword.effects:
			# Assign effect[Enum] = Scene
			$WoodSword.effects[item.effects.effect_type] = item.effects.duplicate()
			#item.remove_child(item.effects)
		else:
			# Increment the amount
			$WoodSword.effects[item.effects.effect_type].count += 1
			print($WoodSword.effects[item.effects.effect_type].count)
	
	if item.debuffs:
		if item.debuffs.debuff_type not in $WoodSword.debuffs:
			$WoodSword.debuffs[item.debuffs.debuff_type] = item.debuffs.duplicate()
			#item.remove_child(item.debuffs)
		else:
			$WoodSword.debuffs[item.debuffs.debuff_type].stacks += 1
	
	item.queue_free()


func update_stats() -> void:
	damage_stat_added = 0
	move_speed_stat_multiplier = 1.0
	
	for item in item_dict:
		match item_dict[item][1].stat_type:
			0: # Move Speed
				move_speed_stat_multiplier += item_dict[item][1].multiplier*item_dict[item][0]
				
			1: # Damage
				damage_stat_added += item_dict[item][1].added*item_dict[item][0]
				damage_stat_multiplier += item_dict[item][1].multiplier*item_dict[item][0]
	
	
	velocity_component.speed_multiplier = move_speed_stat_multiplier
	$WoodSword.update_damage(damage_stat_added, damage_stat_multiplier)




func _physics_process(_delta):
	
	if velocity.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false



