extends Node

# With so much tweening I figured it'd make sense to make a script to handle anything I attach it to.

func tween_to(node: Node, prop: String, value: Variant, duration := 0.5) -> Tween:
	var t := node.create_tween()
	t.tween_property(node, prop, value, duration)
	return t
