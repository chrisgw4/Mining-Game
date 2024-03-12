extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var velocity_component = $VelocityComponent

var is_on_floor = true
var jump_pos: float = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var damage_stat_multiplier:float = 1.0
var gold:float = 0.0


func get_input():
	var dir:Vector2 = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),  Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	
	var past_velocity = velocity_component.Velocity
	
	velocity_component.accelerate_in_direction(dir)
	
	
	if Input.is_action_just_pressed("attack"):
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
	

func _physics_process(delta):
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false




func _process(delta):
	pass
