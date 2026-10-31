extends Control

@export var text_strings: Array[RichTextLabel] = []
var gamepad_input := false

func _ready() -> void:
	_refresh()

func _input(event: InputEvent) -> void:
	var pad_def := event is InputEventJoypadButton or (event is InputEventJoypadMotion and absf(event.axis_value) > 0.5)
	if pad_def and not gamepad_input:
		gamepad_input = true
		_refresh()
	elif (event is InputEventKey or event is InputEventMouseButton) and gamepad_input:
		gamepad_input = false
		_refresh()

func _refresh() -> void:
	for string in text_strings:
		if string.name == "press_start":
			string.text = "press_start_pad" if gamepad_input else "press_start_pc"
