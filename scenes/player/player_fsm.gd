extends FiniteStateMachine


func _init() -> void:
	_add_state("walk")
	_add_state("idle")
	





func _ready() -> void:
	set_state(states.walk)



func _state_logic(_delta: float) -> void:
	#if state == states.idle or state == states.move_side or state == states.move_up or state == states.move_down:
	#if not state in [states.dash_side,states.dash_up,states.dash_down,states.dash_diag_up,states.dash_diag_down]:
		#parent.get_input()
		#parent.move()
	#parent.animated_sprite.flip_h = false
	parent.get_input()



func _get_transition() -> int:

	if parent.velocity.length() > 10:
		return states["walk"]
	else:
		return states["idle"]
	
	return -1


func _enter_state(_previous_state: int, new_state: int) -> void:
	animation_player.play(states_names[new_state])



