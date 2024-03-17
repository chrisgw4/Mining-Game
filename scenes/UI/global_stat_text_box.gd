extends TextureRect
class_name StatTextBox

@export var text:String


@onready var label:RichTextLabel = $RichTextLabel

func _ready() -> void:
	label.text = text


func update_multiplier(num:float):
	label.text = text + str(int(num*100)) + "%" 
