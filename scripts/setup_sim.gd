extends Node2D

var char_per_sec := 20
@onready var text: Node = $TextBox/DialogText

var current_dialog := 1

func _dialog_advance(part: int):
	match part:
		1:
			await text.display_text("intro_1", char_per_sec)
			$TextBox/Arrow.self_modulate.a = 1.0
		2:
			await text.display_text("intro_2", char_per_sec)
			$TextBox/Arrow.self_modulate.a = 1.0
		3:
			await text.display_text("intro_3", char_per_sec)
			$TextBox/Arrow.self_modulate.a = 1.0
		4:
			await text.display_text("intro_4", char_per_sec)
			$TextBox/Arrow.self_modulate.a = 1.0
		5:
			var t := Time.get_time_dict_from_system()
			var time_str := "%02d:%02d" % [t.hour, t.minute]
			await text.display_text(tr("intro_time").format({"time": time_str}))
		_:
			await text.display_text("This is a fallback. You shouldn't be seeing this.", char_per_sec)
			$TextBox/Arrow.self_modulate.a = 1.0

func _ready() -> void:
	$TextBox/Arrow.self_modulate.a = 0.0
	await get_tree().create_timer(1).timeout
	_dialog_advance(current_dialog)
	while is_inside_tree():
		await get_tree().create_timer(0.001).timeout
		if Input.is_action_pressed("ui_accept"):
			if $TextBox/Arrow.self_modulate.a != 1.0:
				print("Not done yet lil bro")
			else:
				current_dialog += 1
				$TextBox/Arrow.self_modulate.a = 0.0
				_dialog_advance(current_dialog)
