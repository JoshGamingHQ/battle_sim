extends Resource
class_name Pokemon

@export var species_name: String
@export var species_id: int
@export var level: int = 50
@export var types: Array[String]
@export var base_stats: Dictionary # {hp, atk, def, spa, spd, spe}
@export var moves: Array[Move]

# Flavor, for my future plans...
@export var abilities: Dictionary
@export var height: float
@export var weight: float
@export var color: String
@export var evolutions: Array[String]
@export var prevo: String
# @export var egg_groups: Array[String]

var current_hp: int
var status: String = "" # Stuff like paralysis, burn, frostbite, etc.
var stat_changes: Dictionary

func setup():
	current_hp = calculate_stat("hp")

func calculate_stat(stat: String) -> int:
	var base = base_stats[stat]
	var iv = 31
	var ev = 0
	var nature_mult = 1 # Eventually I'll add nature alignment
	
	# Individual IVs
	# var hp_iv = 0
	# var atk_iv = 0
	# var def_iv = 0
	# var spa_iv = 0
	#var spd_iv = 0
	# var spe_iv = 0
	
	# Individual EVs
	# var hp_ev = 0
	# var atk_ev = 0
	# var def_ev = 0
	# var spa_ev = 0
	#var spd_ev = 0
	# var spe_ev = 0
	
	if stat == "hp":
		@warning_ignore("integer_division")
		return int(floor((2 * base + iv + (floor(ev / 4))) * level) / 100) + level + 10
	else:
		@warning_ignore("integer_division")
		return int(floor(((floor(((2 * base + iv + (floor(ev / 4))) / 100))) + 5) * nature_mult))
