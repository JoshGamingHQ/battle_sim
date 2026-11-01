extends RichTextLabel

var tween: Tween

func display_text(key: String, chars_per_sec := 20.0) -> void:
	text = key
	visible_characters = 0
	var count := get_total_character_count()
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "visible_characters", count, count / chars_per_sec)
	await tween.finished
