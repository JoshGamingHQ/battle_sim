extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var battle = Battle.new()
	var bulbasaur = load("res://pokemon/bulbasaur.tres")
	var pikachu = load("res://pokemon/pikachu.tres")
	bulbasaur.setup()
	pikachu.setup()
	
	battle.damage_dealt.connect(func(target,amount): print(target.species_name, " took ", amount, " damage - ", target.current_hp))
	
	var action_a = {"type": "move", "user": pikachu, "target": bulbasaur, "move": pikachu.moves[0]}
	var action_b = {"type": "move", "user": bulbasaur, "target": pikachu, "move": bulbasaur.moves[0]}
	battle.execute_turn(action_a,action_b)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
