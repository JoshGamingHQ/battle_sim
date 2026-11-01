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
			match await $SelectBox.get_selection("Yes", "No"):
				"Yes":
					_dialog_advance(100)
				"No":
					_dialog_advance(101)
				"err":
					_dialog_advance(999)
		100:
			var t := Time.get_time_dict_from_system()
			var hour := "%02d" % t.hour
			match hour:
				"00", "01", "02", "03", "04":
					await text.display_text("intro_time_midnight", char_per_sec)
				"05", "06", "07", "08", "09", "10":
					await text.display_text("intro_time_early", char_per_sec)
				"11", "12", "13", "14", "15", "16":
					await text.display_text("intro_time_noon", char_per_sec)
				"17", "18", "19", "20":
					await text.display_text("intro_time_evening", char_per_sec)
				"21", "22", "23":
					await text.display_text("intro_time_night", char_per_sec)
			current_dialog = 5
			$TextBox/Arrow.self_modulate.a = 1.0
		101:
			await text.display_text("intro_time_wrong", char_per_sec)
			current_dialog = 5
			$TextBox/Arrow.self_modulate.a = 1.0
		6:
			await text.display_text("intro_speech_1", char_per_sec)
			match await $SelectBox.get_selection("Explain it", "No help needed"):
				"Explain it":
					_dialog_advance(7)
				"No help needed":
					_dialog_advance(250)
				"err":
					_dialog_advance(999)
		7:
			current_dialog = 250
			await text.display_text("I would but I'm lazy...", char_per_sec)
			$TextBox/Arrow.self_modulate.a = 1.0
		250:
			await text.display_text("intro_deny_explaining", char_per_sec)
			$TextBox/Arrow.self_modulate.a = 1.0
		251: #change this
			await text.display_text("setup_name", (char_per_sec * .5))
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
			if $TextBox/Arrow.self_modulate.a == 1.0:
				current_dialog += 1
				$TextBox/Arrow.self_modulate.a = 0.0
				_dialog_advance(current_dialog)
