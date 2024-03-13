extends StaticBody2D


@export var health_component:HealthComponent

var particle = preload("res://scenes/particle effect/ore_break2.tscn")

@export var value:float
@onready var player = get_tree().current_scene.get_node("SceneHolder1/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.connect("hurt_event", _shake_ore)
	health_component.connect("died_event", _break_ore)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _shake_ore() -> void:
	print("OUCH")
	$AnimationPlayer.play("shake")

func _break_ore() -> void:
	var temp = particle.instantiate()
	temp.global_position = global_position
	get_parent().add_child(temp)
	temp.emitting = true
	queue_free()
	player.gold += value
