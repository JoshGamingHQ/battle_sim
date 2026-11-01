extends Sprite2D

@export var property: String = ""
@export var value1: Variant = 0 # Yeah these should probably be ints but whatever, it works
@export var value2: Variant = 0
@export var time: float = 0.0

func _ready() -> void:
	while is_inside_tree():
		await TweenHandler.tween_to(self, property, value1, time).finished
		await TweenHandler.tween_to(self, property, value2, time).finished
