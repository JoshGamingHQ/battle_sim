extends Sprite2D

func _ready() -> void:
	while is_inside_tree():
		await TweenHandler.tween_to(self, "position:y", 150, 0.7).finished
		await TweenHandler.tween_to(self, "position:y", 160, 0.7).finished
