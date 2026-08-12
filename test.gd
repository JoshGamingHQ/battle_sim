extends Node

func _ready() -> void:
	var battle = Battle.new()
	var bulbasaur = load("res://pokemon/bulbasaur.tres")
	var charmander = load("res://pokemon/charmander.tres")
	var squirtle = load("res://pokemon/squirtle.tres")
	var pikachu = load("res://pokemon/pikachu.tres")
	var arceus = load("res://pokemon/arceusdark.tres") # Yeah that seems fair.
	var arcanine = load("res://pokemon/arcaninehisui.tres")
	var dialga = load("res://pokemon/dialgaorigin.tres")
	var mew = load("res://pokemon/mew.tres")
	var victini = load("res://pokemon/victini.tres")
	var rayquaza = load("res://pokemon/rayquaza.tres") # Just adding more to test, I'll probably be commenting this out
	
	for p in [bulbasaur,charmander,squirtle,pikachu,arceus,arcanine,dialga,mew,victini,rayquaza]:
		p.setup()
		print(p.species_name, " - ", p.moves.size())
	
	battle.team_a = [pikachu, charmander, arcanine, dialga, mew] as Array[Pokemon]
	battle.team_b = [bulbasaur, squirtle, arceus, victini, rayquaza] as Array[Pokemon]
	
	battle.active_a = charmander
	battle.active_b = squirtle
	
	battle.damage_dealt.connect(func(target,amount): print(target.species_name, " took ", amount, " damage - ", target.current_hp))
	battle.pokemon_fainted.connect(func(pkmon): print(pkmon.species_name + " fainted!"))
	battle.fainted_need_to_switch.connect(func(team_label):
		var team = battle.team_a if team_label == "a" else battle.team_b
		for p in team:
			if p.current_hp > 0:
				battle.execute_switch(team_label, p)
				print("Team " + team_label + " sent out " + p.species_name)
				break
	)
	
	
	battle.battle_over.connect(func(winner):
		print("Team " + winner + " wins")
	)
	
	var turn_count = 0
	while not battle.is_over() and turn_count < 500:
		turn_count += 1
		var action_a = {"type": "move", "user": battle.active_a, "target": battle.active_b, "move": battle.active_a.moves[randi() % battle.active_a.moves.size()]}
		var action_b = {"type": "move", "user": battle.active_b, "target": battle.active_a, "move": battle.active_b.moves[randi() % battle.active_b.moves.size()]}
		battle.execute_turn(action_a,action_b)
	
	if turn_count >= 500 and not battle.is_over():
		print("Safety cap hit - something went wrong. Check your code dumbass")
