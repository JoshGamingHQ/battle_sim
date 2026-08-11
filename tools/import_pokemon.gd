@tool
extends EditorScript

const EXCLUDED_MOVES = ["return","frustration","terablast","struggle"]

func _run():
	var dex_file = FileAccess.open("res://data/dex.json", FileAccess.READ)
	var dex_data = JSON.parse_string(dex_file.get_as_text())
	
	var learnset_file = FileAccess.open("res://data/learnsets.json", FileAccess.READ)
	var learnset_data = JSON.parse_string(learnset_file.get_as_text())
	
	for species_id in dex_data.keys():
		var entry = dex_data[species_id]
		if entry.get("num", 0) < 0:
			continue
		var pkmon = Pokemon.new()
		
		pkmon.species_name = entry.get("name", species_id)
		pkmon.species_id = entry.get("num", 0)
		
		pkmon.types = [] as Array[String]
		for t in entry.get("types", []):
			pkmon.types.append(t.to_lower())
			
		pkmon.base_stats = entry.get("baseStats", {})
		pkmon.abilities = entry.get("abilities", {})
		pkmon.height = entry.get("heightm", 0.0)
		pkmon.weight = entry.get("weightkg", 0.0)
		pkmon.color = entry.get("color", "")
		pkmon.evolutions = Array(entry.get("evos", []), TYPE_STRING, "", null) # Apparently this fixes it? I have no idea...
		pkmon.prevo = entry.get("prevo", "")
		
		var learnset_key = species_id
		if not learnset_data.has(species_id) and entry.has("baseSpecies"):
			learnset_key = entry["baseSpecies"].to_lower()
		
		var move_list: Array[Move] = []
		if learnset_data.has(species_id):
			var learnset = learnset_data[species_id].get("learnset", {})
			for move_id in learnset.keys():
				if move_id in EXCLUDED_MOVES:
					continue
				var move_path = "res://moves/%s.tres" % move_id
				if ResourceLoader.exists(move_path):
					move_list.append(load(move_path))
				else:
					push_warning("Missing move resource: %s (needed by %s)" % [move_id, species_id])
		pkmon.moves = move_list
			
		var save_path = "res://pokemon/%s.tres" % species_id
		var err = ResourceSaver.save(pkmon, save_path)
		if err != OK:
			push_error("Failed to save " + save_path)
		else:
			print("Created " + save_path)
