extends Node
class_name VelocityComponent

## Value that limits the speed of the character
@export var max_speed:float = 100.0

## Value that determines the acceleration of the character
@export var acceleration_coeff:float = 10.0

## True if debug mode is active
@export var debug_mode:bool = false


# a speed multiplier to calculate speed with
var speed_multiplier:float = 1.0

# keeps track of the velocity of that the characterbody2d should move at
var Velocity:Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)



# accelerate the velocity to the input vector2
func accelerate_to_velocity(velocity:Vector2) -> void:
	#Velocity = lerp(Velocity, velocity, 2)
	Velocity = velocity*acceleration_coeff
	limit_velocity()


# accelerate to the velocity without restriction of the velocity limit
func force_accelerate_to_velocity(velocity:Vector2) -> void:
	Velocity = velocity*acceleration_coeff


# accelerates the velocity in the direction of the passed input
func accelerate_in_direction(dir:Vector2) -> void:
	if dir != Vector2.ZERO:
		accelerate_to_velocity(dir*max_speed*speed_multiplier)
	else:
		decelerate()


# decelerates the velocity down to (0,0)
func decelerate() -> void:
	#accelerate_to_velocity(Vector2.ZERO)
	Velocity = lerp(Velocity, Vector2.ZERO, 0.15)
	


func limit_velocity() -> void:
	Velocity = Velocity.limit_length(max_speed*speed_multiplier)


func move(character_body:CharacterBody2D) -> void:
	# sets characters velocity to the calculated velocity
	character_body.velocity = Velocity
	
	# calls the move and slide function to move the character
	character_body.move_and_slide()
