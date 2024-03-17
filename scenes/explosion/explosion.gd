extends Node2D


var proc_self_chance:float = 0.0

# Area array to make sure explosion doesnt proc on same rock multiple times
var areas:Array[Area2D] = []
#static var explosion_count:int = 0:
#	set(new_val):
#		if new_val == 0:
#			areas.clear()
#		explosion_count = new_val

# maybe connect area array with signals between the explosion and its children so that run cant hit the same areas, but another wave of explosions can
signal update_areas(new_area:Area2D)

# Called when the node enters the scene tree for the first time.
func _ready():
	#explosion_count+=1
	$AnimationPlayer.play("explode")
	$Hitbox.connect("hit", _proc_itself)

func _decrement_count():
	queue_free()
	#explosion_count-=1

func _proc_itself(pos:Vector2, area:Area2D) -> void:
	if area in areas:
		return
	
	areas.append(area)
	
	var rand = randf_range(0, 1)
	#print("Rand Val: " + str(rand))
	
	if rand <= proc_self_chance:
		print("MULTIBLAST")
		var temp = duplicate()
		temp.areas = areas.duplicate()
		temp.global_position = pos
		get_tree().current_scene.call_deferred("add_child", temp)
		temp.proc_self_chance = proc_self_chance
		connect("update_areas", temp._add_area)
		emit_signal("update_areas", area)
		
	


func _add_area(area:Area2D) -> void:
	if area not in areas:
		areas.append(area)
		emit_signal("update_areas", area)
