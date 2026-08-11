@tool
extends EditorScript

const EXCLUDED = ["return", "frustration", "terablast"]

func _run():
	var file = FileAccess.open("res://data/moves.json",FileAccess.READ)
	var moves_data = JSON.parse_string(file.get_as_text())
	
	for move_id in moves_data.keys():
		if move_id in EXCLUDED:
			continue
			
		var data = moves_data[move_id]
		var move = Move.new()
		
		move.move_id = move_id
		move.move_name = data.get("name", move_id)
		move.num = data.get("num", 0)
		move.type = data.get("type", "Normal").to_lower()
		move.power = data.get("basePower", 0)
		
		var acc = data.get("accuracy", 100)
		move.accuracy = -1 if typeof(acc) == TYPE_BOOL else acc
		
		move.pp = data.get("pp", 0)
		move.category = data.get("category", "Status").to_lower()
		move.priority = data.get("priority", 0)
		move.target = data.get("target", "normal")
		move.flags = data.get("flags", {})
		move.secondary = data.get("secondary", {})
		move.status = data.get("status", "")
		move.boosts = data.get("boosts", {})
		
		var save_path = "res://moves/%s.tres" % move_id
		var err = ResourceSaver.save(move, save_path)
		if err != OK:
			push_error("Failed to save " + save_path)
		else:
			print("Created " + save_path)
