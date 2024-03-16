extends StaticBody2D


@export var health_component:HealthComponent
@export var debuff_component:DebuffComponent

@export var health_bar:ProgressBar
@export var health_label:RichTextLabel


signal destroyed

var particle = preload("res://scenes/particle effect/ore_break2.tscn")

@export var value:float
@onready var player:Player = get_tree().current_scene.get_node("SceneHolder1/Player")

var direction:Vector2 = Vector2.ZERO

var difficulty_scale:float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.connect("hurt_event", _shake_ore)
	health_component.connect("health_changed", _update_health_bar)
	health_component.connect("health_changed", _calculate_strength)
	health_component.connect("died_event", _break_ore)
	
	health_bar.value = health_component.max_health
	health_bar.max_value = health_component.max_health
	health_label.text = str(health_component.max_health)



var strength:float = 1.0

func _update_health_bar(health_stats) -> void:
	health_bar.max_value = health_stats.Max_Health
	health_bar.value = health_stats.Current_Health
	health_label.text = str(health_stats.Current_Health)


func _calculate_strength(health_stats) -> void:
	strength = ((health_stats.Max_Health - health_stats.Current_Health) * 0.115) * (difficulty_scale/(difficulty_scale+1)) * ((health_stats.Max_Health - health_stats.Current_Health)/health_stats.Current_Health)
	#print(strength)
	strength = clampf(strength, .1, 3)
	#print(strength)
	

func _shake_ore() -> void:
	#print(health_component.current_health)
	
	
	
	
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($AnimatedSprite2D, "position", Vector2(-1, 1)*direction*2*strength, .1)
	tween.tween_property($AnimatedSprite2D, "position", Vector2(1, 1)*direction*2*strength, .1)
	tween.tween_property($AnimatedSprite2D, "position", Vector2(0, 0), .2)
	tween.play()
	#$AnimationPlayer.play("shake")

func _break_ore() -> void:
	var temp = particle.instantiate()
	temp.global_position = global_position
	get_parent().add_child(temp)
	temp.emitting = true
	queue_free()
	player.gold += ((value * difficulty_scale) * 0.9) * player.gold_stat_multiplier
	emit_signal("destroyed")


func _change_difficulty(difficulty_scale) -> void:
	health_component.set_max_health(health_component.max_health*difficulty_scale)
	health_component.heal(health_component.max_health)
	self.difficulty_scale = difficulty_scale
	
	
