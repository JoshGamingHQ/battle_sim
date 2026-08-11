extends Node
class_name Battle

signal damage_dealt(target: Pokemon, amount: int)
signal pokemon_fainted(pokemon: Pokemon)
signal status_applied(pokemon: Pokemon, status: String)

var team_a: Array[Pokemon]
var team_b: Array[Pokemon]
var active_a: Pokemon
var active_b: Pokemon

func execute_turn(action_a: Dictionary, action_b: Dictionary):
	var order = _get_turn_order(action_a, action_b)
	for action in order:
		_resolve_action(action)

func _resolve_action(action: Dictionary):
	if action.type == "move":
		var dmg = _calculate_damage(action.user, action.target, action.move)
		action.target.current_hp -= dmg
		damage_dealt.emit(action.target, dmg)
		if action.target.current_hp <= 0:
			pokemon_fainted.emit(action.target)
			
func _calculate_damage(attacker: Pokemon, defender: Pokemon, move: Move) -> int:
	if move.power == 0:
		return 0
	
	var atk_stat: int
	var def_stat: int
	if move.category == "physical":
		atk_stat = attacker.calculate_stat("atk")
		def_stat = defender.calculate_stat("def")
	else:
		atk_stat = attacker.calculate_stat("spa")
		def_stat = defender.calculate_stat("spd")
		
	var level_part = (2.0 * attacker.level / 5.0 + 2.0)
	var base_damage = (level_part * move.power * atk_stat / def_stat) / 50.0 + 2.0
	
	var type_mult = _get_type_multiplier(move.type, defender.types)
	var stab = 1.5 if move.type in attacker.types else 1.0
	var random_factor = randf_range(0.85, 1.0)
	
	var final_damage = base_damage * type_mult * stab * random_factor
	return max(1, int(final_damage))
	
func _get_type_multiplier(move_type: String, defender_types: Array) -> float:
	var mult = 1.0
	for def_type in defender_types:
		mult *= TypeChart.get_effectiveness(move_type, def_type)
	return mult

func _get_turn_order(a: Dictionary, b: Dictionary) -> Array:
	var priority_a = a.move.priority if a.type == "move" else 0
	var priority_b = b.move.priority if b.type == "move" else 0
	if priority_a != priority_b:
		return [a, b] if priority_a > priority_b else [b, a]
		
	var speed_a = a.user.calculate_stat("spe")
	var speed_b = b.user.calculate_stat("spe")
	
	if speed_a == speed_b:
		return [a, b] if randi() % 2 == 0 else [b, a]
	return [a, b] if speed_a > speed_b else [b, a]
