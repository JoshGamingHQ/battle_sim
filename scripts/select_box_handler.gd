extends Panel

var selection: int = 0

var option1Y: int = 50
var option2Y: int = 130

func get_selection(option1: String, option2: String): # hope this works!
	selection = 0
	$Arrow.position.y = option1Y
	modulate.a = 1.0
	$Option1Text.text = option1
	$Option2Text.text = option2
	await get_tree().create_timer(0.005).timeout
	_refresh()
	while is_inside_tree() and modulate.a == 1.0:
		await get_tree().create_timer(0.001).timeout
		if Input.is_action_pressed("ui_accept"):
			modulate.a = 0.0
			if selection == 0:
				return option1
			elif selection == 1:
				return option2
			else:
				return "err" # shouldn't happen, obviously
				
func _select_option() -> void:
	while is_inside_tree() and modulate.a == 1.0:
		await get_tree().create_timer(0.001).timeout
		if Input.is_action_just_released("ui_down") or Input.is_action_just_released("ui_up"): # with only two options this is a terrible way to do this but functionally the same
			if selection == 1:
				selection = 0
				$Arrow.position.y = option1Y
			else:
				selection = 1
				$Arrow.position.y = option2Y
				

func _refresh() -> void:
	_select_option()
