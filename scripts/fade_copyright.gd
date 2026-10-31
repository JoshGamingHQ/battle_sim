extends RichTextLabel

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _fade_in():
	var tween = self.create_tween()
	await tween.tween_property(self, "modulate:a", 1, 0.2).finished
	
func _fade_out():
	var tween = self.create_tween()
	await tween.tween_property(self, "modulate:a", 0, 0.2).finished
	

func _ready():
	await wait(1)
	await _fade_in()
	await wait(2.5)
	await _fade_out()
	await wait(0.5)
	get_tree().change_scene_to_file("res://scenes/title.tscn")
