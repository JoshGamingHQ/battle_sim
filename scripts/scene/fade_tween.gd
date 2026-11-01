extends RichTextLabel

func _fade_in(duration := 0.5) -> void:
	self_modulate.a = 0.0
	var tween := create_tween()
	tween.tween_property(self, "self_modulate:a", 1.0, duration)
	await tween.finished
	
func _fade_out(duration := 0.5) -> void:
	self_modulate.a = 1.0
	var tween := create_tween()
	tween.tween_property(self, "self_modulate:a", 0.0, duration)
	await tween.finished
	
func _ready() -> void:
	while 1:
		await _fade_out()
		await _fade_in()
