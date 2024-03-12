extends Node2D
class_name Shop

signal exit_shop(body)


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("crab")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	emit_signal("exit_shop", body)
