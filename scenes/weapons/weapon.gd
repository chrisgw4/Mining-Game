extends Node2D


@export var hitbox:Hitbox

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func attack() -> void:
	#$AnimationPlayer.speed_scale = 2
	$AnimationPlayer.play("swipe")


func update_damage(damage:float, damage_multiplier:float) -> void:
	hitbox.damage = hitbox.base_damage + damage
	hitbox.damage_multiplier = damage_multiplier
