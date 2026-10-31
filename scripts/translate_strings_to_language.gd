extends Control
@export var text_strings: Array[RichTextLabel] = []

func _ready() -> void:
	for string in text_strings:
		if string.name == "press_start":
			string.text = tr(string.name + "_pc")
		else:
			string.text = tr(string.name)
