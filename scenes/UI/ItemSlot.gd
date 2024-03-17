extends TextureRect
class_name ItemSlot


var item_name:String
var description:String

var count:int

# Store the colorect
@onready var color_rect:ColorRect = $ColorRect



func _on_mouse_entered() -> void:
	if item_name and description:
		$ColorRect/ItemText.text = item_name
		$ColorRect/Description.text = description
		
		# Dynamically changes the size of the color rect
		$ColorRect.size.y = $ColorRect/Description.get_line_count()*11.9 + $ColorRect/ItemText.get_line_count()*13
		
		$AnimationPlayer.play('show')
	


func _on_mouse_exited() -> void:
	if color_rect.visible:
		$AnimationPlayer.play('hide')
